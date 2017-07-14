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



#pragma mark - Selected

- (NSDictionary *)selectFirstItemInT:(NSString *)tableName
                              column:(NSString *)column
{
    NSArray *rs = [self selectInT:tableName
                           fields:nil
                        condition:nil
                      orderFields:@[column]
                         orderASC:YES
                            range:NSMakeRange(0, 1)];
    
    return [rs safeObjAtIndex:0];
}

- (NSDictionary *)selectLastItemInT:(NSString *)tableName
                             column:(NSString *)column
{
    NSArray *rs = [self selectInT:tableName
                           fields:nil
                        condition:nil
                      orderFields:@[column]
                         orderASC:NO
                            range:NSMakeRange(0, 1)];
    
    return [rs safeObjAtIndex:0];
}

- (NSArray <NSDictionary *>*)selectInT:(NSString *)tableName
                                fields:(NSArray<NSString *> *)fields
                             condition:(NSDictionary *)condition
                           orderFields:(NSArray<NSString *> *)orderFields
                              orderASC:(BOOL)orderASC
                                 range:(NSRange)range
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"SELECT "];
    
    //fields
    [sql appendFormat:@"%@ ",[self fieldsSql:fields]];
    
    //表名
    [sql appendFormat:@"FROM %@ ",tableName];
    
    //条件 (可能没有)
    if (![condition isKindOfClass:[NSDictionary class]]){
        [sql appendFormat:@"WHERE %@ ",[self whereSql:condition]];
    }
    
    //orderBY (可能没有)
    if (![NSArray isEmpty:orderFields]){
        [sql appendFormat:@"ORDER BY %@ %@ ",[self fieldsSql:orderFields],orderASC ? @"ASC" : @"DESC"];
    }

    //range
    [sql appendFormat:@"LIMIT %zd,%zd",range.location,range.length];
    
    __block NSMutableArray* results = [NSMutableArray array];
    
    FMDB_QUEUE_IN_DATABASE_START
    
    FMResultSet* rs = [db executeQuery:sql withParameterDictionary:[self conditionKeyDic:condition]];
    if ([db hadError]) {
        LQCDLog(@"Error:%@",[db lastErrorMessage]);
    } else {
        while ([rs next]) {
            [results addObject:rs.resultDictionary];
        }
    }
    [rs close];
    
    FMDB_QUEUE_IN_DATABASE_END
    
    return results;
}









#pragma mark - Insert

- (NSString *)insertSql:(NSString *)tableName
               valueDic:(NSDictionary *)valueDic
{
    NSArray* keys = [valueDic allKeys];
    NSString *sql = Str_F(@"INSERT INTO [%@] ([%@]) VALUES (:%@)",
                          tableName,
                          [keys componentsJoinedByString:@"],["],
                          [keys componentsJoinedByString:@",:"]
                          );
    return sql;
}

- (BOOL)insertTable:(NSString *)tableName
           valueDic:(NSDictionary *)valueDic
{
    NSString *sql = [self insertSql:tableName valueDic:valueDic];
    if ([NSString isEmptyString:sql]) return NO;

    FMDB_QUEUE_UPDATE_BOOL(valueDic);

}


#pragma mark - update

- (NSString *)updateTableSql:(NSString *)tableName
                       value:(NSDictionary *)value
                   condition:(NSDictionary *)condition
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE [%@] ",tableName];
    [sql appendFormat:@"SET %@ ",[self valueSql:value.allKeys]];
    [sql appendFormat:@"WHERE %@",[self whereSql:condition]];
    
    return sql;
}


- (BOOL)updateTable:(NSString *)tableName
              value:(NSDictionary *)value
          condition:(NSDictionary *)condition
{
    NSString *sql = [self updateTableSql:tableName value:value condition:condition];
    FMDB_QUEUE_UPDATE_BOOL([self combinationDicWithValue:value condition:condition]);
}



#pragma mark - replace

- (NSString *)replaceSql:(NSString *)tableName
                valueDic:(NSDictionary *)valueDic
{
    NSArray* valueKeys = [valueDic allKeys];
    NSString *sql = Str_F(@"REPLACE INTO [%@] ([%@]) VALUES (:%@)",
                          tableName,
                          [valueKeys componentsJoinedByString:@"],["],
                          [valueKeys componentsJoinedByString:@",:"]
                          );
    return sql;
}


- (BOOL)replaceTable:(NSString *)tableName
            valueDic:(NSDictionary *)valueDic
{
    NSString *sql = [self replaceSql:tableName
                            valueDic:valueDic];
    if ([NSString isEmptyString:sql]) return NO;
    
    FMDB_QUEUE_UPDATE_BOOL(valueDic);
}




#pragma mark - ziju 

- (NSString *)fieldsSql:(NSArray<NSString *> *)fields
{
    if ([NSArray isEmpty:fields]) return @"*";
    
    return Str_F(@"[%@]",[fields componentsJoinedByString:@"],["]);
}


- (NSString *)whereSql:(NSDictionary *)condtion
{
    if (![condtion isKindOfClass:[NSDictionary class]]){
        return @"1=1";
    }
    
    NSArray* keys = [self conditionKeyDic:condtion].allKeys;
    NSUInteger count = keys.count;
    
    NSMutableString *sql = [NSMutableString string];
    
    for (int i = 0 ; i < count ; i++) {
        [sql appendString:@"["];
        [sql appendString:[keys[i] substringFromIndex:2]];
        [sql appendString:@"]=:"];
        [sql appendString:keys[i]];
        
        if (count > i + 1 ) {
            [sql appendString:@" AND "];
        }
    }
    
    return sql;
}

- (NSString *)valueSql:(NSArray <NSString *> *)keys
{
    NSUInteger count = keys.count;
    NSMutableString *sql = [NSMutableString string];
    
    for (int i = 0 ; i < count ; i++) {
        [sql appendString:@"["];
        [sql appendString:keys[i]];
        [sql appendString:@"]=:"];
        [sql appendString:keys[i]];
        
        if (count > i + 1 ) {
            [sql appendString:@","];
        }
    }
    
    return sql;
}



#pragma mark - privite

- (NSDictionary *)conditionKeyDic:(NSDictionary *)condition
{
    if (![condition isKindOfClass:[NSDictionary class]]){
        return @{};
    }
    
    NSMutableDictionary *rs = [NSMutableDictionary dictionary];
    for (NSObject *key in condition.allKeys) {
        NSString *newKey = Str_F(@"c_%@",[key description]);
        NSObject *value = [condition objectForKey:key];
        [rs setObject:value forKey:newKey];
    }
    
    return rs;
}


- (NSDictionary *)combinationDicWithValue:(NSDictionary *)v
                                condition:(NSDictionary *)c
{
    if (![v isKindOfClass:[NSDictionary class]]){
        return [self conditionKeyDic:c];
    }
    
    NSMutableDictionary *rs = [NSMutableDictionary dictionaryWithDictionary:v];
    NSDictionary *newc = [self conditionKeyDic:c];
    [rs addEntriesFromDictionary:newc];
    return rs;
}


@end
