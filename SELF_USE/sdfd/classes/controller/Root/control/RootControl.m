//
//  RootControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootControl.h"
#import "RootTabbar.h"
#import "RootTabbarItem.h"
#import "BaseNavigationControl.h"
#import "BaseViewController.h"

#import "HomeMainControl.h"
#import "DiscoverMainViewControl.h"
#import "MineMainControl.h"

@interface RootControl ()<RootTabbarDelegate>
{
    RootTabbar *_rootTabbar;
}

@end



@implementation RootControl

+ (RootControl *)defaultRoot
{
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *titles = @[@"首页",@"发现",@"我"];
    NSArray *class = @[@"HomeMainControl",@"DiscoverMainViewControl",@"MineMainControl"];
    for (int_fast8_t i = 0; i < 3; i++) {
        NSString *title = titles[i];
        UIColor *nc = [UIColor lightGrayColor];
        UIColor *sc = [UIColor orangeColor];
        UIImage *ima_n = [UIImage imageNamed:Str_F(@"root_tabar_0%zd_nn",i + 1)];
        UIImage *ima_s = [UIImage imageNamed:Str_F(@"root_tabar_0%zd_ss",i + 1)];
        RootTabbarItem *item = [RootTabbarItem itemWithTitle:title NormalTextColor:nc selectedTextColor:sc normalImage:ima_n selectedImage:ima_s];
        [items addObject:item];
        
        NSString *className = class[i];
        BaseViewController *vc = [[NSClassFromString(className) alloc] init];;
        BaseNavigationControl *nv = [[BaseNavigationControl alloc] initWithRootViewController:vc];
        [controllers addObject:nv];
    }
    
    
    return [self rootControlWithItems:items controllers:controllers];
}



+ (RootControl *)rootControlWithItems:(NSArray *)items controllers:(NSArray *)controllers;
{
    RootControl *root = [[RootControl alloc] init];
    if (![NSArray isEmpty:items]){
        for (int i = 0; i < items.count; i++) {
            RootTabbarItem *item = items[i];
            UIViewController *controller = controllers[i];
            [root addItem:item controller:controller];
        }
    }
    return root;
    
}


- (id)init
{
    if (self = [super init]){
        _rootTabbar = [RootTabbar rootTabbarWithFrame:CGRectMake(0, 0, DeviceWidth, 49.0f)];
        [self.tabBar addSubview:_rootTabbar];
        _rootTabbar.delegate = self;
    }
    return self;
}


- (void)addItem:(RootTabbarItem *)barItem controller:(UIViewController *)controller
{
    [self addChildViewController:controller];
    [_rootTabbar addItem:barItem];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UITabBar *bar = self.tabBar;
    if (!bar) return;
    
    //从这里可以看出来，其实这个东西，是可以改的,我只不过为了好看，不改成70
    CGRect correctF = bar.frame;
//    correctF.size.height = 70;
//    correctF.origin.y = self.view.frame.size.height - 70.0f;
    [bar setFrame:correctF];
    
    CGRect rightfream = bar.bounds;
    [_rootTabbar setFrame:rightfream];
    _rootTabbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    for (UIView *subView in bar.subviews) {
        if (![subView isKindOfClass:[RootTabbar class]]) [subView removeFromSuperview];
    }

}


- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    if (_rootTabbar) [_rootTabbar setSelectedIndex:selectedIndex];
}



#pragma mark - rootTabarDelegate

- (void)rootTabbarView:(RootTabbar *)tabbar didSelectIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
}


- (UIViewController *)childViewControllerForStatusBarStyle
{
    if ([NSArray isEmpty:self.viewControllers]){
        return nil;
    }else{
       return [self.viewControllers safeObjAtIndex:self.selectedIndex];
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



@end
