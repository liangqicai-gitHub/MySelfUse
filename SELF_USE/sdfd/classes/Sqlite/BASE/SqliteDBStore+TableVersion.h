//
//  SqliteDBStore+TableVersion.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/14.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"

@interface SqliteDBStore (TableVersion)

- (NSString *)tableVersion_creatTableSql;

- (BOOL)tableVersion_insertLastVersion:(NSInteger)version
                            versionSql:(NSString *)versionSql;

@end
