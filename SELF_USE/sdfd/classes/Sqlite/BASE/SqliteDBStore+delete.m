//
//  SqliteDBStore+delete.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore+delete.h"

@implementation SqliteDBStore (delete)

- (BOOL)deleteTable:(NSString *)t
{
    NSString *sql = Str_F(@"delete from %@",t);
    
    __block BOOL ret = NO;
    [self.queue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:sql];
        if (!ret){
            LQCDLog(@"%s error:%@",__FUNCTION__,[db lastErrorMessage]);
        }
    }];
    
    return ret;
}


- (BOOL)deleteTable:(NSString *)t condition:(NSDictionary *)cd
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"delete from %@ where ",t];
    NSArray *allfields = [cd allKeys];
    for (NSInteger i = 0; i < allfields.count; i++) {
        NSString *field = allfields[i];
        [sql appendFormat:@"%@ = :%@ ",field,field];
        if (allfields.count > i + 1){
            [sql appendFormat:@"and "];
        }
    }
    
    __block BOOL ret = NO;
    [self.queue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:sql withParameterDictionary:cd];
        if (!ret){
            LQCDLog(@"%s error:%@",__FUNCTION__,[db lastErrorMessage]);
        }
    }];
    
    return ret;
}


@end
