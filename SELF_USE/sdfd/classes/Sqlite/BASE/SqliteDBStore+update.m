//
//  SqliteDBStore+update.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore+update.h"
#import "SqliteDBStore+select.h"
#import "SqliteDBStore+insert.h"
#define kSqliteDBStoreUpdate_cpk @"condition"


// update table set pk = :pk, a = :a where pk = :c_pk and b = :c_b

@implementation SqliteDBStore (update)


- (BOOL)updateOrInsert:(NSString *)t value:(NSDictionary *)vd conditionKey:(NSString *)ck
{
    NSDictionary *cd = @{ck : [vd valueForKey:ck]};
    return [self updateOrInsert:t value:vd condtion:cd];
}


- (BOOL)updateOrInsert:(NSString *)t value:(NSDictionary *)vd condtion:(NSDictionary *)cd
{
    BOOL exist = [self existItemInTable:t condition:cd];
    if (exist){
        return [self updateTable:t value:vd condition:cd];
    }else{
        return [self insertTable:t value:vd];
    }
}


- (BOOL)updateTable:(NSString *)t value:(NSDictionary *)vd conditionKey:(NSString *)ck
{
    NSDictionary *cd = @{ck : [vd valueForKey:ck]};
    return [self updateTable:t value:vd condition:cd];
}


- (BOOL)updateTable:(NSString *)t value:(NSDictionary *)vd condition:(NSDictionary *)cd
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"update %@ set ",t];
    
    NSArray *allFields = vd.allKeys;
    NSInteger fieldsCount = allFields.count;
    for (NSInteger i = 0; i < fieldsCount; i++) {
        NSString *field = allFields[i];
        [sql appendFormat:@"%@ = :%@",field,field];
        if (i + 1 < fieldsCount){
            [sql appendFormat:@", "];
        }else{
            [sql appendFormat:@" "];
        }
    }
    
    [sql appendFormat:@"where "];
    
    NSArray *allCF = cd.allKeys;
    NSInteger cfCount = allCF.count;
    for (NSInteger i = 0; i < cfCount; i++) {
        NSString *field = allCF[i];
        [sql appendFormat:@"%@ = :%@%@",field,kSqliteDBStoreUpdate_cpk,field];
        if (i + 1 < fieldsCount){
            [sql appendFormat:@" and "];
        }else{
            [sql appendFormat:@" "];
        }
    }
    
    NSDictionary *vcd = [self mergeValue:vd condition:cd];
    
    __block BOOL ret = NO;
    [self.queue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:sql withParameterDictionary:vcd];
        if (!ret){
            LQCDLog(@"%s error:%@",__FUNCTION__,[db lastErrorMessage]);
        }
    }];
    
    return ret;
}


- (NSDictionary *)mergeValue:(NSDictionary *)vd condition:(NSDictionary *)cd
{
    __block NSMutableDictionary *rs = [NSMutableDictionary dictionary];
    if ([vd isKindOfClass:[NSDictionary class]]){
        [rs addEntriesFromDictionary:vd];
    }
    
    if ([cd isKindOfClass:[NSDictionary class]]){
        NSArray <NSString *>*allkeys = cd.allKeys;
        [allkeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
            NSString *newKey = Str_F(@"%@%@",kSqliteDBStoreUpdate_cpk,obj);
            id value = [cd objectForKey:obj];
            [rs setObject:value forKey:newKey];
        }];
    }
    
    return rs;
}

@end
