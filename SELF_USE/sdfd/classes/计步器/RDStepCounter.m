//
//  RDStepCounter.m
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RDStepCounter.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "RDStepCounterFacade.h"
#import "SqlManager.h"
#import "CommonDB+TableStep.h"

@interface RDStepCounter ()
{
    CMMotionManager *_motionManager;
    CLLocationManager *_locationManager;
    NSOperationQueue *_operationQueue;
    dispatch_queue_t _calculateQueue;//串行的
}

@property (nonatomic, strong) RDStepCounterFacade *stepCounterFacade;
@property (nonatomic,copy) UpdateBlock upblock;

@end


@implementation RDStepCounter


+ (instancetype)sharedStepCounter
{
    static RDStepCounter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RDStepCounter alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    [self initVars];
    return self;
}


- (void)initVars
{
    _operationQueue = [[NSOperationQueue alloc] init];
    _calculateQueue = dispatch_queue_create("calculate", DISPATCH_QUEUE_SERIAL);
    _stepCounterFacade = [[RDStepCounterFacade alloc] init];
    
    _locationManager = [[CLLocationManager alloc] init];
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = 1.0 / 60.0;
    _motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization]; // 永久授权
    }
    
    if([_locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
        [_locationManager requestAlwaysAuthorization]; // 永久授权
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    [_locationManager startUpdatingLocation];
    [_motionManager startAccelerometerUpdates];
    
    
    [_motionManager
     startDeviceMotionUpdatesToQueue:_operationQueue
     withHandler:^(CMDeviceMotion *motion, NSError *error){
         dispatch_async(_calculateQueue, ^{
             [self callbackCurStepsWithMotion:motion];
         });
     }];
}

- (void)callbackCurStepsWithMotion:(CMDeviceMotion *)motion
{
    BOOL oneStepMore = [_stepCounterFacade
                        signalInputWithX:motion.userAcceleration.x
                        y:motion.userAcceleration.y
                        z:motion.userAcceleration.z];
    
    if (oneStepMore){
        CommonDB *db = [SqlManager sharedInstance].commonDB;
        [db tableStep_insertRecordWithDate:[NSDate date] steps:1];
        
        dispatch_async(_calculateQueue, ^{
            if (self.upblock) self.upblock([NSDate date]);
        });
    }
}


- (void)queryFormDate:(NSDate *)startDate
              endDate:(NSDate *)endDate
              handler:(QueryBlock)handler
{
    CommonDB *db = [SqlManager sharedInstance].commonDB;
    NSInteger steps = [db tableStep_queryStepsSinceDate:startDate toDate:endDate];
    if (handler) handler(steps);
}

- (void)startUpdateWithHandler:(UpdateBlock)handler
                          fail:(AuthorizationFailedBlock)fail
{
    [self stopUpdate];
    
    dispatch_async(_calculateQueue, ^{
        self.upblock = handler;
    });
}

- (void)stopUpdate
{
    dispatch_async(_calculateQueue, ^{
        self.upblock = nil;
    });
}

@end
