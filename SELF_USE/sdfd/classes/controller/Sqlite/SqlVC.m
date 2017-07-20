//
//  SqlVC.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqlVC.h"
#import "SqlManager.h"
#import "CommonDB+TableStep.h"
#import "NSDate+RDLogic.h"
#import "SqliteDBStore+update.h"


@interface SqlVC ()

@end

@implementation SqlVC

#pragma mark - life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVars];
    [self initViews];
}


- (void)initVars
{
//    [[SqlManager sharedInstance] switchOverToUser:@"a"];
//    
//    RDOneDayStepM *m = [[RDOneDayStepM alloc] init];
//    m.date = [NSDate date].startDate;
//    
//    [[SqlManager sharedInstance].commonDB insertOneDay:m];
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (NSInteger i = 0; i < 23; i++) {
//        RDHourStepM *hm = [[RDHourStepM alloc] init];
//        hm.hour = i;
//        hm.steps = 100 * i;
//        [arr addObject:hm];
//    }
//    m.hourSteps = arr;
//    
//    [[SqlManager sharedInstance].commonDB updateOneDay:m];
//    
//    
//    [[SqlManager sharedInstance].commonDB updateOneDay:m];
    
}

- (void)initViews
{
    NSDictionary *d = @{@"pk" : @(1),
                        @"ss" : @"dsfsdf",
                        @"bb" : @"sdfdf"
                        };
    [[SqlManager sharedInstance].commonDB updateTable:@"tt" value:d condition:d];
    
}

@end
