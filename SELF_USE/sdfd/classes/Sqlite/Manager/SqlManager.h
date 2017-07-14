//
//  SqlManager.h
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDB.h"
#import "CommonDB.h"

@interface SqlManager : NSObject

+ (SqlManager *)sharedInstance;

- (void)switchOverToUser:(NSString *)userId;

@property (nonatomic,readonly) UserDB *currentUserDB;

@property (nonatomic,readonly) CommonDB *commonDB;

@end
