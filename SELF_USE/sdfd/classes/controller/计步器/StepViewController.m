//
//  StepViewController.m
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "StepViewController.h"
#import "RDStepService.h"
#import "HealthKit.h"

@interface StepViewController ()
{
    RDStepService *_service;
}

@end

@implementation StepViewController

- (IBAction)click:(UIButton *)sender
{
//    if (!_service){
//        _service = [[RDStepService alloc] init];
//    }
    
    
    [[HealthKit alloc] init];
    
//    [_service queryHistoryWithCompleteBlock:^(NSArray<RDOneDayStepM *> *historyArr) {
//        LQCDLog(@"%@",historyArr);
//    }];
    
    
//    [_service startWithHandler:^(BOOL authorizationFailed, RDOneDayStepM *todayStep) {
//        
//    }];
}



@end
