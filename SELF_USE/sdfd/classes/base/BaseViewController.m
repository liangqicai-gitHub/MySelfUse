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
    [self setDefaultNavigationBack:YES];
     self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController
     setNavigationBarHidden:[self navigationBarHidden]
     animated:animated];
}


#pragma mark - statusbar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - navigation

- (BOOL)navigationBarHidden
{
    return NO;
}

- (BOOL)supportSlideBack
{
    return YES;
}

- (void)setDefaultNavigationBack:(BOOL)useLastControllerTitle
{
    UINavigationController *navi = self.navigationController;
    if (!navi) return;
    
    NSArray *controllers = navi.viewControllers;
    if (![NSArray isArray:controllers equalOrLongerThan:2]) return;//至少要是第二个
    
    NSString *title = @"返回";
    if (useLastControllerTitle){
        UIViewController *last = controllers[controllers.count - 2];
        NSString *lastTitle = last.title;
        if (![NSString isEmptyString:lastTitle]){
            title = lastTitle;
        }
    }
    
    UIImage *backImage = [UIImage imageNamed:@"cm-navi-back-n"];
    UIFont *titleFont = [UIFont systemFontOfSize:18];
    UIButton *backBtn = [UIButton newInstanceWithTitle:title
                                                  font:titleFont
                                      normalTitleColor:[UIColor whiteColor]
                                   horizontalAlignment:UIControlContentHorizontalAlignmentLeft
                                           normalImage:backImage];
    
    CGFloat titleWidth = [title sizeForFont:titleFont
                                       size:(CGSize){CGFLOAT_MAX,30}
                                       mode:backBtn.titleLabel.lineBreakMode].width;
    CGFloat backBtnWidth = titleWidth + backImage.size.width;
    [backBtn setFrame:(CGRect){0,0,backBtnWidth + 7,44}];
    [backBtn setTitleEdgeInsets:(UIEdgeInsets){0,5,0,0}];
    
    UIBarButtonItem *navigationSpacer = [[UIBarButtonItem alloc] init];
    navigationSpacer.width = -5;
    
    NSArray *leftItems = @[navigationSpacer,
                           [[UIBarButtonItem alloc] initWithCustomView:backBtn]
                           ];
    
    self.navigationItem.leftBarButtonItems = leftItems;
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

- (void)pushTo:(BaseViewController *)vc
     animation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    [navi pushViewController:vc animated:animation];
}



@end
