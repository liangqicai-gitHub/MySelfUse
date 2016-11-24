//
//  BaseViewController.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark - navigation

/*
 默认是NO，
 子类可以重写该方法
 */
- (BOOL)navigationHidden;

- (void)popTo:(BaseViewController *)vc
      animation:(BOOL)animation;

- (void)pustTo:(BaseViewController *)vc
     animation:(BOOL)animation;

- (void)setDefaultNavigationBack;

@end
