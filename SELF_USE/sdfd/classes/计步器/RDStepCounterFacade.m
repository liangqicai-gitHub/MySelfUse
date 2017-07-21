//
//  RDStepCounterFacade.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/21.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RDStepCounterFacade.h"


@implementation RDSignalRangeAvgModel

#pragma mark - final

- (NSInteger)signalAvgCacheSize
{
    return 100;
}

- (void)reset
{
    self.bInited = NO;
    self.avg = 0;
    self.sum = 0;
    self.signalPos = 0;
}

#pragma mark - lazy

- (NSMutableArray *)signalSource
{
    if (!_signalSource) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        //非原子性 异步 所以要防止数组越界 把数组扩大十倍
        for (int i = 0; i < [self signalAvgCacheSize] * 10; i ++) {
            [mutableArray addObject:@0];
        }
        _signalSource = mutableArray;
    }
    
    return _signalSource;
}

#pragma mark - public

- (NSInteger)getWindowSize
{
    return [self signalAvgCacheSize];
}

- (void)input:(CGFloat)data
{
    //防止多线程共享资源导致数组越界
    NSInteger signalPos = self.signalPos;
    signalPos %= [self signalAvgCacheSize];
    
    self.oldTmpData = [self.signalSource[signalPos] floatValue];
    self.sum += data;
    self.signalSource[signalPos] = @(data);
    if (self.bInited) {
        self.sum -= self.oldTmpData;
        self.avg = self.sum / [self signalAvgCacheSize];
    }else
    {
        if (signalPos == 0) {
            self.avg = self.sum / [self signalAvgCacheSize];
            self.bInited = YES;
        }
    }
    
    self.signalPos ++;
    self.signalPos %= [self signalAvgCacheSize];
}

- (BOOL)hasInited
{
    return self.bInited;
}

- (CGFloat)getAvg
{
    return self.avg;
}

@end


@implementation RDPeakDetectedMachine

#pragma mark - lazy

- (RDSignalRangeAvgModel *)avgModel
{
    if (!_avgModel) {
        _avgModel = [RDSignalRangeAvgModel new];
    }
    return _avgModel;
}

#pragma mark - final

- (CGFloat)peakLimitFactor
{
    return 1.38;
}

- (CGFloat)peakMinimumSwing
{
    return 0.85;
}

- (CGFloat)minTimeDelta
{
    return 0.265;
}

#pragma mark - public

- (void)openTimeDetected
{
    self.bCheckTime = YES;
}

- (NSString *)getStatePrint
{
    return [NSString stringWithFormat:@"Step:%ld rate-filter:%ld avg-fiter:%ld s-filter:%ld", (long)self.peakCounter, (long)self.rateCounter, (long)self.underAvgCounter, (long)self.swingCounter];
}

- (void)reset
{
    [self.avgModel reset];
    self.bInit = NO;
    self.signalNum = 1;
}

- (BOOL)isAvgModelReady
{
    return [self.avgModel hasInited];
}

- (RDSignalRangeAvgModel *)getAvgModel
{
    return self.avgModel;
}

- (BOOL)input:(CGFloat)data
{
    self.signalNum ++;
    [self.avgModel input:fabs(data)];
    
    if (![self.avgModel hasInited]) {
        return NO;
    }
    
    if (!self.bInit) {
        self.bInit = YES;
        self.controlData = self.previousData = data;
        self.lastStepTime = 0;
        self.peakCounter = self.rateCounter = self.underAvgCounter = self.swingCounter = 0;
        return NO;
    }
    
    if (self.previousData == data) {
        return NO;
    }
    
    if (self.previousData < data) {
        self.previousData = self.controlData = data;
        return NO;
    }
    
    BOOL isPeak = NO;
    
    if (self.previousData >= self.controlData) {
        if (self.previousData < [self.avgModel getAvg] * [self peakLimitFactor]) {
            self.underAvgCounter++;
        } else if (self.previousData < [self peakMinimumSwing]) {
            self.swingCounter++;
        } else {
            NSTimeInterval timeInterval = [NSDate date].timeIntervalSince1970;
            if (!self.bCheckTime || timeInterval - self.lastStepTime > [self minTimeDelta]) {
                self.lastStepTime = [NSDate date].timeIntervalSince1970;
                isPeak = true;
                self.peakCounter++;
            } else {
                self.rateCounter++;
                if(self.lastStepTime > timeInterval) {   // 剔除用户设置系统时间造成的影响
                    self.lastStepTime = 0;
                }
            }
        }
    } else {
        
    }
    self.previousData = data;
    
    return isPeak;
}

@end


@implementation RDStepCounterFacade

#pragma mark - final

- (BOOL)pauseDetectedEnable
{
    return false;
}

- (NSInteger)pauseDetectedLimit
{
    return 40;
}

- (NSInteger)pauseLockTime
{
    return 3;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mPeakMachine = [RDPeakDetectedMachine new];
        [_mPeakMachine openTimeDetected];
    }
    return self;
}

#pragma mark - public

- (void)reset
{
    [self.mPeakMachine reset];
    self.mIsPause = YES;
    self.mPauseMarkTime = 0;
    self.pauseCounter = 0;
}

- (BOOL)signalInputWithX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z
{
    CGFloat length = sqrt(pow(x, 2.0) + pow(y, 2.0) + pow(z, 2.0));
    BOOL b = [self.mPeakMachine input:length];
    
    if (![self pauseDetectedEnable]) {
        return b;
    }
    
    if (self.mIsPause) {
        if (b) {
            if (self.mPauseMarkTime == 0) {  // 强行吃掉状态迁移信号
                self.mPauseMarkTime = [NSDate date].timeIntervalSince1970;
            } else {
                NSTimeInterval gap = self.mPauseMarkTime = [NSDate date].timeIntervalSince1970 - self.mPauseMarkTime;
                if (gap > [self pauseDetectedLimit] || gap < 0) {
                    self.mPauseMarkTime = 0;
                } else if (gap > [self pauseLockTime]) {
                    self.mPauseMarkTime = [NSDate date].timeIntervalSince1970;
                    self.mIsPause = false;
                }
            }
            if (self.mIsPause) {
                b = false;  // 在 Pause 状态一定时间内，强制锁住信号
                self.mPeakMachine.peakCounter--; // 计数撤消
                self.pauseCounter++;
            }
        }
    } else {
        if (b) {
            self.mPauseMarkTime = [NSDate date].timeIntervalSince1970;
        } else {
            long gap = [NSDate date].timeIntervalSince1970 - self.mPauseMarkTime;
            if (gap > [self pauseDetectedLimit] || gap < 0) {
                self.mIsPause = true;
                self.mPauseMarkTime = 0;    // 特殊标记
            }
        }
    }
    
    return b;
}

@end

