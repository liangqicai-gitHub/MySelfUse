//
//  TestNavigationBaseViewController.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/24.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "TestNavigationBaseViewController.h"

@interface TestNavigationBaseViewController ()

@end

@implementation TestNavigationBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController
     setNavigationBarHidden:[self navigationBarHidden]
     animated:animated];
}


- (BOOL)navigationBarHidden
{
    return NO;
}

@end
