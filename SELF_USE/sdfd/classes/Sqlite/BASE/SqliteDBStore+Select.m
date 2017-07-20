//
//  SqliteDBStore+select.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/19.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore+select.h"

#define SqliteDBStoreSelectRS(set,rs) if (set){ \
while ([set next]) { \
[rs addObject:set.resultDictionary]; \
} \
}else{ \
LQCDLog(@"%s error:%@",__FUNCTION__,[db lastErrorMessage]); \
} \
[set close]

@implementation SqliteDBStore (select)

#pragma mark - 查询一张表中的所有记录,返回的记录包含所有的列

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
{
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sql = Str_F(@"select * from %@",t);
        FMResultSet *set = [db executeQuery:sql];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return rs;
}

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                              orderByField:(NSString *)field
{
    return [self selectInTable:t orderByField:field ASC:YES];
}

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                              orderByField:(NSString *)field
                                       ASC:(BOOL)ASC
{
    NSDictionary *d = @{field : @(ASC)};
    return [self selectInTable:t orderByFields:@[d]];
}

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                             orderByFields:(NSArray <NSDictionary *>*)fields
{
    
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sql = Str_F(@"select * from %@ order by %@",t,[self orderBy:fields]);
        FMResultSet *set = [db executeQuery:sql];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return rs;
}

- (NSString *)orderBy:(NSArray <NSDictionary *>*)fields
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < fields.count ; i++) {
        NSDictionary *d = fields[i];
        NSString *key = d.allKeys[0];
        BOOL asc = [d.allValues[0] boolValue];
        [sql appendFormat:@"%@ %@, ",key,asc ? @"ASC" : @"DESC"];
    }
    return sql;
}


#pragma mark - 查找第一个，或者最后一个 （按照某一个 field 排序）
- (NSDictionary *)firstItemInTable:(NSString *)t
                      orderByField:(NSString *)field
{
    NSDictionary *d = @{field : @(YES)};
    NSString *sql = Str_F(@"select * from %@ order by %@ LIMIT 1",t,[self orderBy:@[d]]);
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return [rs safeObjAtIndex:0];
}


- (NSDictionary *)lastItemInTable:(NSString *)t
                     orderByField:(NSString *)field
{
    NSDictionary *d = @{field : @(NO)};
    NSString *sql = Str_F(@"select * from %@ order by %@ LIMIT 1",t,[self orderBy:@[d]]);
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return [rs safeObjAtIndex:0];
}


#pragma mark - 按照条件查找

/*condtion 中，只是 = 条件*/
- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                                 condition:(NSDictionary *)condition
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"select * from %@ where",t];
    NSArray *allfields = [condition allKeys];
    for (NSInteger i = 0; i < allfields.count; i++) {
        NSString *field = allfields[i];
        [sql appendFormat:@" %@ = :%@",field,field];
        if (allfields.count > i + 1){
            [sql appendFormat:@" and"];
        }
    }
   
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql withParameterDictionary:condition];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return rs;
}


/*查询的where子句，可以写得很复杂，自己想怎么写就怎么写*/
- (NSArray <NSDictionary *>*)selectWithSql:(NSString *)sql
{
    __block NSMutableArray *rs = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        SqliteDBStoreSelectRS(set, rs);
    }];
    
    return rs;
}




@end
