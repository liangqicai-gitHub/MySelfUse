//
//  SqliteDBStore+update.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"

@interface SqliteDBStore (update)

/* 
 update table set pk = :pk, a = :a where pk = :c_pk b = :c_b
 */


/* vd 中请包含 ck字段 */
- (BOOL)updateTable:(NSString *)t value:(NSDictionary *)vd conditionKey:(NSString *)ck;

- (BOOL)updateTable:(NSString *)t value:(NSDictionary *)vd condition:(NSDictionary *)cd;

/* vd 中请包含 pk字段 */
- (BOOL)updateOrInsert:(NSString *)t value:(NSDictionary *)vd conditionKey:(NSString *)ck;

- (BOOL)updateOrInsert:(NSString *)t value:(NSDictionary *)vd condtion:(NSDictionary *)cd;

@end
