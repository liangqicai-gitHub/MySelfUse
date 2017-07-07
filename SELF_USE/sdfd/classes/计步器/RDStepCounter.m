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

@interface RDStepCounter ()
{
    CMMotionManager *_motionManager;
    CLLocationManager *_locationManager;
    NSOperationQueue *_operationQueue;
    
}

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
    _locationManager = [CLLocationManager new];
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = 0.5;
    _motionManager.deviceMotionUpdateInterval = 0.5;
    _operationQueue = [NSOperationQueue new];
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
    [_motionManager startDeviceMotionUpdatesToQueue:_operationQueue
                                        withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                            LQCDLog(@" %@   %@",[NSOperationQueue currentQueue],[NSThread currentThread]);
                                            
                                            
                                        }];
}



@end
