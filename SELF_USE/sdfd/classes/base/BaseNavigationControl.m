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
    UIColor *barColor = [UIColor whiteColor];
    barColor = [barColor colorWithAlphaComponent:0.8];
    UIImage *barImage = [barColor pureColorImage];
    [self.navigationBar setBackgroundImage:barImage
                             forBarMetrics:UIBarMetricsDefault];
    
    UIColor *titleColor = HexRGB(0xfecb16);
    NSDictionary *titleAttributes = @{
                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                      NSForegroundColorAttributeName:titleColor
                                      };
    self.navigationBar.translucent = YES;
    [self.navigationBar setTitleTextAttributes:titleAttributes];
}



- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSArray *controllers = self.viewControllers;
    if ([NSArray isEmpty:controllers]) return NO;
    if (controllers.count > 1) return YES;
    return NO;
}


@end
