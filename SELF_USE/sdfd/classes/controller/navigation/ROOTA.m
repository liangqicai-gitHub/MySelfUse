//
//  ROOTA.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/22.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "ROOTA.h"
#import "AVC.h"

@interface ROOTA ()<UIGestureRecognizerDelegate>

@end

@implementation ROOTA


+ (ROOTA *)newInstance
{
    ROOTA *instance = [[ROOTA alloc]
                       initWithRootViewController:[[AVC alloc] init]];
    
    UIColor *whiteColor = [UIColor blackColor];
    whiteColor = [whiteColor colorWithAlphaComponent:0.8];
    
    [instance.navigationBar
     setBackgroundImage:[whiteColor pureColorImage]
     forBarMetrics:UIBarMetricsDefault];
    instance.navigationBar.translucent = NO;
    
    instance.interactivePopGestureRecognizer.delegate = instance;
    
    return instance;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSArray *controllers = self.viewControllers;
    if ([NSArray isEmpty:controllers]) return NO;
    if (controllers.count > 1) return YES;
    return NO;
}


@end
