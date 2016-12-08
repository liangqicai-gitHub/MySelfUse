//
//  RootControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootControl.h"
#import "RootTabbar.h"
#import "BaseNavigationControl.h"
#import "BaseViewController.h"
#import "HomeMainControl.h"
#import "DiscoverMainViewControl.h"
#import "MineMainControl.h"



@interface RootControl ()
<
RootTabbarDelegate,
UINavigationControllerDelegate
>
{
    RootTabbar *_rootTabbar;
}

@end



@implementation RootControl


+ (RootControl *)rootControl
{
    RootControl *instance = [[RootControl alloc] init];
    
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
    }
    return self;
}


- (void)initVars
{
    NSArray *class =
    @[@"HomeMainControl",@"DiscoverMainViewControl",@"MineMainControl"];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSString *className in class) {
        BaseViewController *vc = [[NSClassFromString(className) alloc] init];;
        BaseNavigationControl *nv = [[BaseNavigationControl alloc]
                                     initWithRootViewController:vc];
        [viewControllers addObject:nv];
        [self addChildViewController:nv];
        nv.delegate = self;
    }
    
    _selectedIndex = -1;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSelectedIndex:0];
}


- (void)initViews
{
    _rootTabbar = [[RootTabbar alloc] init];
    _rootTabbar.delegate = self;
    _rootTabbar.backgroundColor = [RGB(250, 250, 250) colorWithAlphaComponent:0.9];
    [self.view addSubview:_rootTabbar];
    [_rootTabbar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo([RootTabbar expectedHeight]);
    }];
}


#pragma mark - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) return;
    _selectedIndex = selectedIndex;
    
    UINavigationController *childVC = self.childViewControllers[_selectedIndex];
    if (!childVC.view.superview){
        [self.view addSubview:childVC.view];
    }
    [self.view bringSubviewToFront:childVC.view];
    
    CGFloat height = DeviceHeight;
    if (![NSArray isArray:childVC.viewControllers equalOrLongerThan:2]){
        height = DeviceHeight - [RootTabbar expectedHeight];
    }
    
    [childVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(height);
    }];
    
    [_rootTabbar selectItemAtIndex:_selectedIndex];
}


#pragma mark - rootTabarDelegate

- (void)rootTabbar:(RootTabbar *)tabbar didClickedIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
}


#pragma mark - StatusBarStyle

- (UIViewController *)childViewControllerForStatusBarStyle
{
    if ([NSArray isEmpty:self.childViewControllers]){
        return nil;
    }else{
       return [self.childViewControllers safeObjAtIndex:self.selectedIndex];
    }
}


#pragma mark - 横屏控制

- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
   return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark navVC代理
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    if (viewController != root) {

        [navigationController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(DeviceHeight);
        }];
        [navigationController.view setNeedsLayout];
        [navigationController.view layoutIfNeeded];
        
        [_rootTabbar removeFromSuperview];

        [root.view addSubview:_rootTabbar];
        [_rootTabbar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo([RootTabbar expectedHeight]);
        }];
        
        [_rootTabbar setNeedsLayout];
        [_rootTabbar layoutIfNeeded];
    }
}


-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {

        [navigationController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(DeviceHeight - [RootTabbar expectedHeight]);
        }];
        
        [navigationController.view setNeedsLayout];
        [navigationController.view layoutIfNeeded];
        
        [_rootTabbar removeFromSuperview];

        [self.view addSubview:_rootTabbar];

        [_rootTabbar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo([RootTabbar expectedHeight]);
        }];
        
        [self.view bringSubviewToFront:_rootTabbar];
        
        [_rootTabbar setNeedsLayout];
        [_rootTabbar layoutIfNeeded];
    }
}

@end
