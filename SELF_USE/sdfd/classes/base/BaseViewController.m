//
//  BaseViewController.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end


@implementation BaseViewController


#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - statusbar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - navigation

- (BOOL)navigationHidden
{
    return NO;
}

- (void)popTo:(BaseViewController *)vc
    animation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    
    if (vc){
        [navi popToViewController:vc animated:animation];
    }else{
        [navi popViewControllerAnimated:animation];
    }
}

- (void)pustTo:(BaseViewController *)vc
     animation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    [navi pushViewController:vc animated:animation];
}




@end
