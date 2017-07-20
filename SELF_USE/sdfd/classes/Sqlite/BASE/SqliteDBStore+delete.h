//
//  SqliteDBStore+delete.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/20.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqliteDBStore.h"


/* DELETE FROM tt where a = :a */

@interface SqliteDBStore (delete)



- (BOOL)deleteTable:(NSString *)t;


/*只能是等于*/
- (BOOL)deleteTable:(NSString *)t condition:(NSDictionary *)cd;



@end
