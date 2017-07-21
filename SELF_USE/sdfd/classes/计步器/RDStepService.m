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
    NSDate *_lastUpdateTime;
    RDOneDayStepM *_currentDayStepM;
    dispatch_semaphore_t _queryOneDaysema;// 第一次查询 一天的详细信息，还未完成时，不允许第二次开始
    dispatch_queue_t _queryOneDayQueue;
}

@end



@implementation RDStepService


#define OneByOneQuery_oneDayDetail_begin dispatch_async(_queryOneDayQueue, ^{ \
dispatch_semaphore_wait(_queryOneDaysema, DISPATCH_TIME_FOREVER);


#define OneByOneQuery_oneDayDetail_end    dispatch_semaphore_signal(_queryOneDaysema); \
});

#pragma mark - init

+ (void)beginRecordData
{
    if (![self useAppleStepCounter]){
        [RDStepCounter sharedStepCounter];
    }
}


+ (BOOL)useAppleStepCounter
{
    BOOL useAppleStepCounter = [CMPedometer isStepCountingAvailable];
//    useAppleStepCounter = NO;
    return useAppleStepCounter;
}

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
    if ([RDStepService useAppleStepCounter]){
        _counter = [[AppleStepCounter alloc] init];
    }else{
        _counter = [RDStepCounter sharedStepCounter];
    }
    
    _queryOneDaysema = dispatch_semaphore_create(1);
    _queryOneDayQueue = dispatch_queue_create("_queryOneDayQueue", DISPATCH_QUEUE_SERIAL);
    
    
    _lastUpdateTime = [NSDate date];
    _currentDayStepM = [[RDOneDayStepM alloc] init];
    _currentDayStepM.date = _lastUpdateTime.startDate;
    _currentDayStepM.hourSteps = [NSMutableArray array];
}


#pragma mark - public function

- (void)queryHistoryWithCompleteBlock:(HistoryBlock)completeBlock
{
    dispatch_group_t group = dispatch_group_create();
    
    NSInteger week = _lastUpdateTime.weekday;
    NSDate *firstStart = [_lastUpdateTime weekStartDate];
  
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



- (void)startWithHandler:(UpdateTodayBlock)handler
{
    [self callBackUpdateLastUpdateDate:[NSDate date]
                               handler:handler];
    
    __weak typeof(self) weakSelf = self;
    [_counter startUpdateWithHandler:^(NSDate *endDate) {
        if (!weakSelf) return ;
        [weakSelf callBackUpdateLastUpdateDate:endDate handler:handler];
    } fail:^{
        dispatch_main_async_safe(^{
            if (handler) handler(YES,nil,NO);
        });
    }];
}


- (void)callBackUpdateLastUpdateDate:(NSDate *)lastDate
                             handler:(UpdateTodayBlock)handler
{
    OneByOneQuery_oneDayDetail_begin
    
    BOOL secondDay = NO;
    if ([_lastUpdateTime earlyThanDate:lastDate.startDate]){
        //第二天
        _lastUpdateTime = lastDate;
        [_currentDayStepM.hourSteps removeAllObjects];
        _currentDayStepM.date = _lastUpdateTime.startDate;
        secondDay = YES;
    }
    
    //开始查询今天的详细数据
    NSInteger lastH = _lastUpdateTime.hour;
    NSInteger queryedH = 0;
    if (![NSArray isEmpty:_currentDayStepM.hourSteps]){
        queryedH = [_currentDayStepM.hourSteps.lastObject hour];
    }
    
    dispatch_semaphore_t eachHourS = dispatch_semaphore_create(1);
    
    NSDate *oneDayMorning = _currentDayStepM.date;
    for (NSInteger i = queryedH; i < lastH + 1; i++) {
        dispatch_semaphore_wait(eachHourS, DISPATCH_TIME_FOREVER);
        NSDate *start = [NSDate dateWithTimeInterval:3600 * i  sinceDate:oneDayMorning];
        NSDate *end = [NSDate dateWithTimeInterval:3600 sinceDate:start];
    
        [_counter queryFormDate:start endDate:end handler:^(NSInteger steps) {
    
            NSInteger count = _currentDayStepM.hourSteps.count;
            if (i < count){//修改
                RDHourStepM *hourM = _currentDayStepM.hourSteps[i];
                hourM.steps = steps;
            }else{//添加
                RDHourStepM *hourM = [[RDHourStepM alloc] init];
                hourM.hour = start.hour;
                hourM.steps = steps;
                [_currentDayStepM.hourSteps addObject:hourM];
            }
            
            dispatch_semaphore_signal(eachHourS);
        }];
    }
    
    NSInteger d = dispatch_semaphore_wait(eachHourS, DISPATCH_TIME_FOREVER);
    LQCDLog(@"aaaaaaa  %zd",d);
    NSInteger x = dispatch_semaphore_signal(eachHourS);
    LQCDLog(@"bbbbbbb  %zd",x);
    
    
    
    dispatch_main_async_safe(^{
        if (handler) handler(NO,_currentDayStepM,YES);
    });
    
    OneByOneQuery_oneDayDetail_end
}


- (void)stop
{
    [_counter stopUpdate];
}


@end
