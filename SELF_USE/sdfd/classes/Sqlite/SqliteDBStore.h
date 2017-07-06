//
//  SqliteDBStore.h
//  sdfd
//
//  Created by 梁齐才 on 17/6/28.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface SqliteDBStore : NSObject

- (instancetype)initWithDBPath:(NSString *)DBPath
                    encryptKey:(NSString *)encryptKey;

- (void)close;


/*维护一个版本*/
/* 子类可以重写这个方法，在一个数据库被初始化的时候，内部调用该方法
   子类无需主动调用。
 */
- (BOOL)updateDBStoreAction;


- (BOOL)updateToVersion:(NSInteger)version
             inDatabase:(void(^)(FMDatabase *db))updateSql;


/*Selecte*/
- (NSArray *)selectedFormT:(NSString *)tableName
                conditions:(NSDictionary *)conditions;


@end
