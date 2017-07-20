//
//  SqliteDBStore.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/28.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"
#import "SqliteDBStore+TableVersion.h"


#define FMDB_QUEUE_IN_DATABASE_START [_queue inDatabase:^(FMDatabase *db) {
#define FMDB_QUEUE_IN_DATABASE_END   }];


#define FMDB_QUEUE_UPDATE_BOOL(allDic) __block BOOL ret = NO; \
FMDB_QUEUE_IN_DATABASE_START \
LQCDLog(@"sql =%@",sql); \
ret = [db executeUpdate:sql withParameterDictionary:allDic]; \
if ([db hadError]) { \
    LQCDLog(@"Error: %@", [db lastErrorMessage]); \
} \
FMDB_QUEUE_IN_DATABASE_END \
return ret;



@implementation SqliteDBStore


#pragma mark - init

- (instancetype)initWithDBPath:(NSString *)DBPath
                    encryptKey:(NSString *)encryptKey
{
    self = [super init];
    if (self){
        [self initVarsPath:DBPath encryptyKey:encryptKey];
    }
    return self;
}


- (void)initVarsPath:(NSString *)path
         encryptyKey:(NSString *)encryptyKey
{
    NSAssert(![NSString isEmptyString:path], @"path is null");
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    //设置密码
    if (![NSString isEmptyString:encryptyKey]){
        [_queue inDatabase:^(FMDatabase *db) {
            [db setKey:encryptyKey];
        }];
    }
    
    //创建Version表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeStatements:[self tableVersion_creatTableSql]];
    }];
    
    //执行数据库更新脚本
    [self updateDBStoreAction];
}



- (void)updateDBStoreAction
{
    NSDictionary *updates = [self versionSqlDic];
    if (![updates isKindOfClass:[NSDictionary class]]) return;

    NSArray <NSString *>* allKeys = [updates allKeys];
    NSArray *sortedAllKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1,
                                                                                     NSString *obj2) {
        NSInteger one = obj1.integerValue;
        NSInteger two = obj2.integerValue;
        return [@(one) compare:@(two)];
    }];
    
    
    for (NSInteger i = 0; i < sortedAllKeys.count; i++) {
        NSString *version = sortedAllKeys[i];
        NSString *sql = updates[version];

        BOOL updateToVersion = [self tableVersion_insertLastVersion:version.integerValue
                                                         versionSql:sql];
        
        if (!updateToVersion) break;
        
    }
}


- (NSDictionary *)versionSqlDic
{
    return @{};
}


- (void)close
{
    [_queue close];
}


@end
