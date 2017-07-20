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




@end
