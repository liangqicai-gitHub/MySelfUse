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

- (NSString *)description
{
    return Str_F(@" \r\n  %zd: %zd",_hour,_steps);
}

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
    NSDate *_currentDate;
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
    
    _currentDate = [NSDate date].startDate;
}


#pragma mark - public function

- (void)queryHistoryWithCompleteBlock:(HistoryBlock)completeBlock
{
    dispatch_group_t group = dispatch_group_create();
    
    NSDate *now = [NSDate date];
    NSInteger week = now.weekday;
    NSDate *firstStart = [now weekStartDate];
  
    NSTimeInterval oneDay = 3600.0 * 24.0;
    
    NSMutableArray <RDOneDayStepM *> *rs = [NSMutableArray array];
    NSLock *lock = [[NSLock alloc] init];
    
    for (NSInteger i = 0; i < week; i++) {
        dispatch_group_enter(group);
        NSDate *end = [NSDate dateWithTimeInterval:oneDay * (i + 1) sinceDate:firstStart];
        NSDate *start = [NSDate dateWithTimeInterval:oneDay * i sinceDate:firstStart];
        
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



- (void )queryOneDay:(NSDate *)oneDay completeBlock:(void (^)(RDOneDayStepM *oneDay))completeBlock
{
    RDOneDayStepM *rs = [[RDOneDayStepM alloc] init];
    rs.date = oneDay.startDate;
    rs.hourSteps = [NSMutableArray array];
    
    //查询每个小时
    dispatch_group_t group = dispatch_group_create();
    NSTimeInterval oneHour = 3600.0;
    
    NSLock *lock = [[NSLock alloc] init];
    
    NSInteger count = oneDay.hour;
    if (count == 0) count = 24;
    
    for (NSInteger i = 0; i < count + 1; i++) {
        dispatch_group_enter(group);
        NSDate *end = [NSDate dateWithTimeInterval:oneHour * (i + 1) sinceDate:rs.date];
        NSDate *start = [NSDate dateWithTimeInterval:oneHour * i sinceDate:rs.date];
        
        RDHourStepM *hourM = [[RDHourStepM alloc] init];
        [_counter queryFormDate:start endDate:end handler:^(NSInteger steps) {
            hourM.hour = start.hour;
            hourM.steps = steps;
            [lock lock];
            [rs.hourSteps addObject:hourM];
            [lock unlock];
            
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [rs.hourSteps sortUsingComparator:^NSComparisonResult(RDHourStepM *obj1, RDHourStepM *obj2) {
            return [@(obj1.hour) compare:@(obj2.hour)];
        }];
        
        if (completeBlock) completeBlock(rs);
    });
}




- (void)startWithHandler:(UpdateTodayBlock)handler
{
    [self queryOneDay:_currentDate completeBlock:^(RDOneDayStepM *oneDay) {
        if (handler) handler(NO,oneDay,YES);
    }];
    
    [_counter startUpdateWithHandler:^(NSDate *endDate){
        
        if ([_currentDate earlyThanDate:endDate.startDate]){//到了第二天了
            _currentDate = endDate.startDate;
            [self queryOneDay:endDate completeBlock:^(RDOneDayStepM *oneDay) {
                if (handler) handler(NO,oneDay,YES);
            }];
            
        }else{
            [self queryOneDay:endDate completeBlock:^(RDOneDayStepM *oneDay) {
                if (handler) handler(NO,oneDay,NO);
            }];
        }
        
    } fail:^{
        if (handler) handler(YES,nil,NO);
    }];
}


- (void)stop
{
    [_counter stopUpdate];
}


@end
