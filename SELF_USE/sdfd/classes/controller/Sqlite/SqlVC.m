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
#import "SqliteDBStore+insert.h"
#import "SqliteDBStore+select.h"
#import "SqliteDBStore+delete.h"


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
    
}

- (void)initViews
{
    NSDictionary *d = @{@"date" : @(111),
                        @"step" : @(223)
                        };
    
    
    
    BOOL a = [[SqlManager sharedInstance].commonDB updateTable:@"step" value:d condition:@{@"step" : @(223)}];
    if (a){
        LQCDLog(@"yes");
    }else{
        LQCDLog(@"NO");
    }
    
    
}

@end
