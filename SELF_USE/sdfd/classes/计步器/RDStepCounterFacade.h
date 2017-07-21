//
//  RDStepCounterFacade.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/21.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RDSignalRangeAvgModel : NSObject

@property (nonatomic, strong) NSMutableArray *signalSource;
@property (nonatomic, assign) NSInteger signalPos;
@property (nonatomic, assign) CGFloat sum;
@property (nonatomic, assign) CGFloat avg;
@property (nonatomic, assign) BOOL bInited;
@property (nonatomic, assign) CGFloat oldTmpData;

- (void)reset;
- (NSInteger)getWindowSize;
- (void)input:(CGFloat)data;
- (BOOL)hasInited;
- (CGFloat)getAvg;

@end


@interface RDPeakDetectedMachine : NSObject

@property (nonatomic, assign) BOOL bInit;
@property (nonatomic, assign) BOOL bCheckTime;
@property (nonatomic, strong) RDSignalRangeAvgModel *avgModel;
@property (nonatomic, assign) CGFloat previousData;
@property (nonatomic, assign) NSInteger signalNum;
@property (nonatomic, assign) CGFloat controlData;
@property (nonatomic, assign) NSTimeInterval lastStepTime;
@property (nonatomic, assign) NSInteger peakCounter;
@property (nonatomic, assign) NSInteger rateCounter;
@property (nonatomic, assign) NSInteger underAvgCounter;
@property (nonatomic, assign) NSInteger swingCounter;

- (void)openTimeDetected;
- (NSString *)getStatePrint;
- (void)reset;
- (BOOL)isAvgModelReady;
- (RDSignalRangeAvgModel *)getAvgModel;
- (BOOL)input:(CGFloat)data;

@end


@interface RDStepCounterFacade : NSObject


@property (nonatomic, strong) RDPeakDetectedMachine *mPeakMachine;
@property (nonatomic, assign) BOOL mIsPause;
@property (nonatomic, assign) NSTimeInterval  mPauseMarkTime;
@property (nonatomic, assign) NSInteger pauseCounter;

- (void)reset;
- (BOOL)signalInputWithX:(CGFloat)x
                       y:(CGFloat)y
                       z:(CGFloat)z;


@end
