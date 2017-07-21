//
//  RDStepService.h
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "StepCounter.h"

@interface RDHourStepM : NSObject

@property (assign) NSInteger hour;
@property (assign) NSInteger steps;

@end


@interface RDOneDayStepM : NSObject

@property (nonatomic,strong) NSDate *date;
@property (assign) NSInteger totalSteps;
@property (nonatomic,strong) NSMutableArray <RDHourStepM *> *hourSteps;

@end

typedef void(^HistoryBlock)(NSArray <RDOneDayStepM *> * historyArr);
typedef void(^UpdateTodayBlock)(BOOL authorizationFailed,RDOneDayStepM *todayStep,BOOL newDay);



@interface RDStepService : NSObject

/*APPDelegate中调用，因为5s以下的设备，是需要开启的*/
+ (void)beginRecordData;

/*如果没有查询到，就给你返空数组  在主线程中返回  hourSteps是空的*/
- (void)queryHistoryWithCompleteBlock:(HistoryBlock)completeBlock;

/*如果授权失败的话，会返回授权失败，在主线程中返回*/
- (void)startWithHandler:(UpdateTodayBlock)handler;


- (void)stop;

@end
