//
//  BaseNavigationControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaseNavigationControl.h"
#import "BaseViewController.h"

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
    barColor = [barColor colorWithAlphaComponent:0.99];
    UIImage *barImage = [barColor pureColorImage];
    [self.navigationBar setBackgroundImage:barImage
                             forBarMetrics:UIBarMetricsDefault];
    
    UIColor *titleColor = [UIColor blackColor];
    NSDictionary *titleAttributes = @{
                                      NSFontAttributeName:[UIFont systemFontOfSize:16],
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
    //是否是root，如果是，则返回NO
    NSArray *controllers = self.viewControllers;
    if ([NSArray isEmpty:controllers]) return NO;
    if (controllers.count == 1) return NO;
    
    UIViewController *top = self.topViewController;
    if (![top isKindOfClass:[BaseViewController class]]) return NO;
    return [(BaseViewController *)top supportSlideBack];
    
}


@end
