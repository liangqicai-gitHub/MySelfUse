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

#import "SqlManager.h"
#import "CommonDB+TableStep.h"

@interface StepViewController ()
{
    RDStepService *_service;
}
@property (weak, nonatomic) IBOutlet UILabel *aa;

@end

@implementation StepViewController

- (IBAction)click:(UIButton *)sender
{
    if (!_service){
        _service = [[RDStepService alloc] init];
    }
    
 
    
    [_service startWithHandler:^(BOOL authorizationFailed,
                                 RDOneDayStepM *todayStep,
                                 BOOL newDay) {
        
        if (todayStep){
            dispatch_main_async_safe((^{
                
                NSMutableString *rs = [[NSMutableString alloc] initWithFormat:@"%zd",todayStep.date.day];
                [todayStep.hourSteps enumerateObjectsUsingBlock:^(RDHourStepM * _Nonnull obj,
                                                                  NSUInteger idx,
                                                                  BOOL * _Nonnull stop) {
                    [rs appendString:obj.description];
                }];
                
                LQCDLog(@"startWithHandler %zd",todayStep.hourSteps.count);
                _aa.text = rs;
                
            }));
        }
        
        
        
    }];
    
   
    
    
//    [_service startWithHandler:^(BOOL authorizationFailed, RDOneDayStepM *todayStep) {
//        
//    }];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_service stop];
}


@end
