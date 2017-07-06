//
//  SqlVC.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqlVC.h"
#import "SqlManager.h"


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
    [[SqlManager sharedInstance] switchOverToUser:@"a"];
}

- (void)initViews
{
    
}

@end
