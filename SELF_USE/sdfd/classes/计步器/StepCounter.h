//
//  StepCounter.h
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^QueryBlock)(NSInteger steps);

typedef void(^UpdateBlock)(NSDate *endDate);

typedef void(^AuthorizationFailedBlock)();

@interface StepCounter : NSObject

- (void)queryFormDate:(NSDate *)startDate
              endDate:(NSDate *)endDate
              handler:(QueryBlock)handler;

- (void)startUpdateWithHandler:(UpdateBlock)handler
                          fail:(AuthorizationFailedBlock)fail;

- (void)stopUpdate;

@end
