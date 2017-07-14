//
//  SqliteDBStore+TableVersion.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/14.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore+TableVersion.h"

#define KVersionTableName @"version"
#define KVersionColumnPK @"id"
#define KVersionColumnSql @"sql"


@implementation SqliteDBStore (TableVersion)


- (NSString *)tableVersion_creatTableSql
{
    NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"t_version" ofType:@"sql"];
    NSString *creatTableSql = [[NSString alloc]
                               initWithContentsOfFile:sqlPath
                               encoding:NSUTF8StringEncoding
                               error:nil];
    return creatTableSql;
}

- (BOOL)tableVersion_insertLastVersion:(NSInteger)version
                            versionSql:(NSString *)versionSql
{
    if ([NSString isEmptyString:versionSql]) return NO;
    
    NSInteger lastVersion = 0;
    NSDictionary *versionD = [self selectLastItemInT:KVersionTableName
                                              column:KVersionColumnPK];
    if (versionD){
        lastVersion = [versionD[KVersionColumnPK] integerValue];
    }
    if (lastVersion >= version) return YES;
    
    __block BOOL success = YES;
    
    NSDictionary *changeVersionDic = @{KVersionColumnPK:@(version),
                                       KVersionColumnSql:versionSql
                                       };
    
    NSString *changeVersionSql = [self replaceSql:KVersionTableName valueDic:changeVersionDic];
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL one = [db executeUpdate:versionSql];
        BOOL two = [db executeUpdate:changeVersionSql
             withParameterDictionary:changeVersionDic];
        success = one && two;
        if (!success){
            *rollback = YES;
            return;
        }
    }];
    
    return success;
}




@end
