//
//  SqliteDBStore+update.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"

@interface SqliteDBStore (update)

- (BOOL)updateTable:(NSString *)t value:(NSDictionary *)vd condtion:(NSDictionary *)cd;

@end
