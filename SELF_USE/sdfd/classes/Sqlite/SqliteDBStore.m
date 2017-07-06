//
//  SqliteDBStore.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/28.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"


@interface SqliteDBStore ()
{
    FMDatabaseQueue *_queue;
}



@end


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
    if (![NSString isEmptyString:encryptyKey]){
        [_queue inDatabase:^(FMDatabase *db) {
            [db setKey:encryptyKey];
        }];
    }
    
    [self creatVersionTable];
    [self updateDBStoreAction];
}


#pragma mark - versions
- (BOOL)creatVersionTable
{
    NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"Version" ofType:@"sql"];
    NSString *creatTableSql = [[NSString alloc]
                               initWithContentsOfFile:sqlPath
                               encoding:NSUTF8StringEncoding
                               error:nil];
    
    __block BOOL rs = NO;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rs = [db executeUpdate:creatTableSql];
    }];
    
    return rs;
}


- (BOOL)updateDBStoreAction
{
    return NO;
}


- (BOOL)updateToVersion:(NSInteger)version
             inDatabase:(void(^)(FMDatabase *db))updateSql
{
    
    
    
    [_queue inTransaction:^(FMDatabase *db,
                            BOOL *rollback) {
        
        
    }];
    
    return NO;
}


#pragma mark - private


- (void)close
{
    [_queue close];
}



#pragma mark - Selected

- (NSArray *)selectedFormT:(NSString *)tableName
                conditions:(NSDictionary *)conditions
{
    [_queue inDatabase:^(FMDatabase *db) {
//        [db executeQuery:<#(NSString *)#> values:<#(NSArray *)#> error:<#(NSError *__autoreleasing *)#>]
    }];
    return nil;
}


@end
