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
    dispatch_queue_t _calculateQueue;
}

@property (nonatomic, strong) RDStepCounterFacade *stepCounterFacade;

@end


@implementation RDStepCounter

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
        LQCDLog(@"heheda");
        CommonDB *db = [SqlManager sharedInstance].commonDB;
        [db tableStep_insertRecordWithDate:[NSDate date] steps:1];
    }
}


@end
