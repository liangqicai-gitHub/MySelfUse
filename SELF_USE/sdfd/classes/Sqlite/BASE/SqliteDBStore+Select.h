//
//  SqliteDBStore+select.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/19.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"


/*
 SELECT a as aa, b as bb from t_table WHERE a > 0 and b < 100 ORDER by a DESC, b ASC LIMIT 100
 
 select 语句不要乱加括号。(where 子句可以加括号)
 
 如果要使用字典，可以写成
 
 SELECT a as aa, b as bb from t_table WHERE a = :akey and b < :bkey ORDER by a DESC, b ASC LIMIT 100
 
 */


@interface SqliteDBStore (select)

/*查询一张表中的所有记录,返回的记录包含所有的列*/
- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t;

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                              orderByField:(NSString *)field;

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                              orderByField:(NSString *)field
                                       ASC:(BOOL)ASC;

- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                             orderByFields:(NSArray <NSDictionary *>*)fields;


/*查找第一个，或者最后一个 （按照某一个 field 排序）*/
- (NSDictionary *)firstItemInTable:(NSString *)t
                      orderByField:(NSString *)field;

- (NSDictionary *)lastItemInTable:(NSString *)t
                     orderByField:(NSString *)field;


/*按照条件查找*/

/*查询的where子句，可以写得很复杂，自己想怎么写就怎么写*/
- (NSArray <NSDictionary *>*)selectWithSql:(NSString *)sql;

/*condtion 中，只是 = 条件*/
- (NSArray <NSDictionary *>*)selectInTable:(NSString *)t
                                 condition:(NSDictionary *)condition;


- (BOOL)existItemInTable:(NSString *)t
               condition:(NSDictionary *)condition;

@end
