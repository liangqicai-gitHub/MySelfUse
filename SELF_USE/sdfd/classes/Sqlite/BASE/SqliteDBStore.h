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

@property (nonatomic,readonly) FMDatabaseQueue *queue;

- (void)close;


/*维护一个版本   子类重写这个方法*/
/* @{   @"1":@"creat table" ,
        @"2":@"creat table"  } */
- (NSDictionary *)versionSqlDic;


/*Selecte*/

// first or last item 因为按照顺序来，就需要按什么字段排序，所以需要一个列的名称。
- (NSDictionary *)selectFirstItemInT:(NSString *)tableName
                              column:(NSString *)column;

- (NSDictionary *)selectLastItemInT:(NSString *)tableName
                             column:(NSString *)column;

- (NSArray <NSDictionary *>*)selectInT:(NSString *)tableName
                                fields:(NSArray<NSString *> *)fields
                             condition:(NSDictionary *)condition
                           orderFields:(NSArray<NSString *> *)orderFields
                              orderASC:(BOOL)orderASC
                                 range:(NSRange)range;

/*Insert*/
- (BOOL)insertTable:(NSString *)tableName
           valueDic:(NSDictionary *)valueDic;


/*update*/
- (BOOL)updateTable:(NSString *)tableName
              value:(NSDictionary *)value
          condition:(NSDictionary *)condition;


/*replace*/
- (NSString *)replaceSql:(NSString *)tableName
                valueDic:(NSDictionary *)valueDic;

- (BOOL)replaceTable:(NSString *)tableName
            valueDic:(NSDictionary *)valueDic;



//子句
- (NSString *)fieldsSql:(NSArray<NSString *> *)fields;

- (NSString *)whereSql:(NSDictionary *)condtion;

- (NSString *)valueSql:(NSArray <NSString *> *)keys;

@end
