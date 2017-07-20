//
//  SqliteDBStore+insert.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore+insert.h"

#define SqliteDBStoreInsert_Return(sql,vd)  __block BOOL ret = NO; \
[self.queue inDatabase:^(FMDatabase *db) { \
    ret = [db executeUpdate:sql withParameterDictionary:vd]; \
    if (!ret){ \
        LQCDLog(@"%s error:%@",__FUNCTION__,[db lastErrorMessage]); \
    } \
}]; \
return ret;


// INSERT INTO authors (identifier, name, date, comment) VALUES (:identifier, :name, :date, :comment)

@implementation SqliteDBStore (insert)

- (BOOL)insertTable:(NSString *)t value:(NSDictionary *)vd
{
    NSString *sql = Str_F(@"insert into %@ %@",t,[self valueSqlWithValue:vd]);
    SqliteDBStoreInsert_Return(sql, vd)
}


- (BOOL)insertOrReplace:(NSString *)t value:(NSDictionary *)vd;
{
    NSString *sql = Str_F(@"insert or replace into %@ %@",t,[self valueSqlWithValue:vd]);
    SqliteDBStoreInsert_Return(sql, vd)
}


- (BOOL)insertOrIgnore:(NSString *)t value:(NSDictionary *)vd
{
    NSString *sql = Str_F(@"insert or IGNORE into %@ %@",t,[self valueSqlWithValue:vd]);
    SqliteDBStoreInsert_Return(sql, vd)
}

//  (a, b, c) values (:a, :b, :c)
- (NSString *)valueSqlWithValue:(NSDictionary *)vd
{
    NSString *fields = [vd.allKeys componentsJoinedByString:@", "];
    NSString *values = Str_F(@":%@",[vd.allKeys componentsJoinedByString:@", :"]);
    return Str_F(@"(%@) values (%@)",fields,values);
}

@end
