//
//  RDStepService.m
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RDStepService.h"
#import "AppleStepCounter.h"
#import "RDStepCounter.h"
#import <CoreMotion/CoreMotion.h>
#import "NSDate+RDLogic.h"


@implementation RDHourStepM



@end


@implementation RDOneDayStepM

- (NSString *)description
{
    return Str_F(@"date : %f  /r/n   step : %zd",_date.timeIntervalSince1970,_totalSteps);
}

@end



@interface RDStepService ()
{
    StepCounter *_counter;
}

@end



@implementation RDStepService


#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
    }
    return self;
}


- (void)initVars
{
    BOOL useAppleStepCounter = [CMPedometer isStepCountingAvailable];
    if (useAppleStepCounter){
        _counter = [[AppleStepCounter alloc] init];
    }else{
        _counter = [[RDStepCounter alloc] init];
    }
}


#pragma mark - public function

- (void)queryHistoryWithCompleteBlock:(HistoryBlock)completeBlock
{
    dispatch_group_t group = dispatch_group_create();
    
    NSDate *firstEnd = [NSDate dateWithTimeInterval:-1
                                          sinceDate:[NSDate date].startDate];
  
    NSTimeInterval oneDay = 3600.0 * 24.0;
    
    NSMutableArray <RDOneDayStepM *> *rs = [NSMutableArray arrayWithCapacity:7];
    NSLock *lock = [[NSLock alloc] init];
    
    for (NSInteger i = 0; i < 7; i++) {
        dispatch_group_enter(group);
        NSDate *end = [NSDate dateWithTimeInterval:-oneDay * i sinceDate:firstEnd];
        NSDate *start = end.startDate;
        
        __block RDOneDayStepM *oneDay = [[RDOneDayStepM alloc] init];
        oneDay.date = start;
        [_counter queryFormDate:start endDate:end handler:^(NSInteger steps) {
            oneDay.totalSteps = steps;
            
            [lock lock];
            [rs addObject:oneDay];
            [lock unlock];
            
            dispatch_group_leave(group);
        }];
    }
    
   dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       [rs sortUsingComparator:^NSComparisonResult(RDOneDayStepM *obj1, RDOneDayStepM *obj2) {
           return [@(obj1.date.timeIntervalSince1970) compare:@(obj2.date.timeIntervalSince1970)];
       }];
       if (completeBlock) completeBlock(rs);
   });
}


- (void)startWithHandler:(UpdateTodayBlock)handler
{
    [_counter startUpdateWithHandler:^(NSDate *lastUpdateTime, NSDate *endDate, NSInteger steps) {
        
    } fail:^{
        
    }];
}


@end
