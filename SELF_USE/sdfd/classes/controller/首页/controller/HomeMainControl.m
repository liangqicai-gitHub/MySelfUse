//
//  HomeControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "HomeMainControl.h"
#import "testButtonVC.h"

@interface HomeMainControl ()


@end

@implementation HomeMainControl


- (NSString *)title
{
    return @"首页";
}


- (IBAction)testButtonLayout:(UIButton *)sender
{
    testButtonVC *vc = [[testButtonVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushTo:vc animation:YES];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"ddddddd---%f",DeviceHeight);
    NSLog(@"home self.frame %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"home self.nav.frame %@",NSStringFromCGRect(self.navigationController.view.frame));
}


@end
