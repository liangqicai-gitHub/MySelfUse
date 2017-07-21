//
//  AppleStepCounter.m
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "AppleStepCounter.h"
#import <CoreMotion/CoreMotion.h>

@interface AppleStepCounter ()
{
    CMPedometer *_CMPedometer;
}

@end


@implementation AppleStepCounter


#pragma mark - init

- (instancetype)init
{
    self = [super init];
    [self initVars];
    return self;
}


- (void)initVars
{
    _CMPedometer = [[CMPedometer alloc] init];
}


#pragma mark - overwrite
- (void)queryFormDate:(NSDate *)startDate
              endDate:(NSDate *)endDate
              handler:(QueryBlock)handler
{
    [_CMPedometer
     queryPedometerDataFromDate:startDate
     toDate:endDate
     withHandler:^(CMPedometerData * _Nullable pedometerData,
                   NSError * _Nullable error) {
         if (handler){
             NSInteger steps = error ? 0 : pedometerData.numberOfSteps.integerValue;
             handler(steps);
         }
     }];
}



- (void)startUpdateWithHandler:(UpdateBlock)handler
                          fail:(AuthorizationFailedBlock)fail
{
    [_CMPedometer
     startPedometerUpdatesFromDate:[NSDate date]
     withHandler:^(CMPedometerData * _Nullable pedometerData,
                   NSError * _Nullable error) {
         
         if (!error && handler){
             NSDate *end = pedometerData.endDate;
             handler(end);
         }
         
         if (error && error.code == CMErrorMotionActivityNotAuthorized && fail){
             fail();
         }
     }];
}


- (void)stopUpdate
{
    [_CMPedometer stopPedometerUpdates];
}


@end
