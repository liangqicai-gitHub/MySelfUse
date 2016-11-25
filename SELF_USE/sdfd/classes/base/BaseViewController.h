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

- (BOOL)navigationBarHidden;

- (BOOL)supportSlideBack;

- (void)setDefaultNavigationBack:(BOOL)useLastControllerTitle;

- (void)popTo:(BaseViewController *)vc
      animation:(BOOL)animation;

- (void)pushTo:(BaseViewController *)vc
     animation:(BOOL)animation;


@end
