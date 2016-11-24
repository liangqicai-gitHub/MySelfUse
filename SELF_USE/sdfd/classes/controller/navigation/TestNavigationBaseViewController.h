//
//  TestNavigationBaseViewController.h
//  sdfd
//
//  Created by 梁齐才 on 16/11/24.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestNavigationBaseViewController : UIViewController

- (BOOL)navigationBarHidden;

- (void)popToVC:(TestNavigationBaseViewController *)vc
      animation:(BOOL)animation;

- (void)pushToVC:(TestNavigationBaseViewController *)vc
       animation:(BOOL)animation;

@end
