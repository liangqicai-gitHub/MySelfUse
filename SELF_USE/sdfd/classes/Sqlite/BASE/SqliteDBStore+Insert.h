//
//  SqliteDBStore+insert.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"

/*
 INSERT INTO authors (identifier, name, date, comment) VALUES (:identifier, :name, :date, :comment)
 */


@interface SqliteDBStore (insert)

- (BOOL)insertTable:(NSString *)t value:(NSDictionary *)vd;

/*先去了解一下   insert or replace 的工作原理
 
 建议是：vd 里面一定要包含主键，
 因为他会先去查找 唯一约束的列，找到有，则删除整条记录，然后插入。
 也就是说，其他列原来有值，但是你在vd中没有包含这些列，那么如果vd中包含的主键被查找到，那么其他列就为空了）
 
 eg：INSERT OR REPLACE INTO tt (pk) VALUES (1);
 
 原来本来有一条数据   
 pk   a   b   c
 1   2   2   2
 
 那么这条命令下来，就会变成：
 pk   a   b   c
 1    0   0   0

 */
- (BOOL)insertOrReplace:(NSString *)t value:(NSDictionary *)vd;

/*先去了解一下   INSERT OR IGNORE 的工作原理  和上面差不多*/
- (BOOL)insertOrIgnore:(NSString *)t value:(NSDictionary *)vd;

@end
