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

@property (nonatomic,strong) NSDate *firstEffectiveDate;

- (void)queryHistoryWithCompleteBlock:(HistoryBlock)completeBlock;

- (void)startWithHandler:(UpdateTodayBlock)handler;

- (void)stop;

@end
