//
//  BaseNavigationControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaseNavigationControl.h"

@interface BaseNavigationControl ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationControl


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]){
        [self configerNavigationBar];
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (void)configerNavigationBar
{
    self.navigationBar.translucent = NO;
    UIColor *barTintColor = [[UIColor alloc] initWithRed:1.0f green:0 blue:0 alpha:0.5];
    self.navigationBar.barTintColor = barTintColor;
    
    UIColor *titleColor = HexRGB(0xfecb16);
    NSDictionary *titleAttributes = @{
                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                      NSForegroundColorAttributeName:titleColor
                                      };
    [self.navigationBar setTitleTextAttributes:titleAttributes];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSArray *controllers = self.childViewControllers;
    if ([NSArray isEmpty:controllers]) return NO;
    if (controllers.count > 1) return YES;
    return NO;
}


@end
