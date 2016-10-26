//
//  AppDelegate.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "AppDelegate.h"
#import "RootControl.h"
#import "BaseNavigationControl.h"

@interface AppDelegate ()
{
    BMKMapManager* _mapManager; 
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpBaiDuMap];
    [self configerRoot];
    return YES;
}


- (void)configerRoot
{
    if (!_window){
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    
    RootControl *root = [RootControl defaultRoot];
    _window.rootViewController = root;
}



- (void)setUpBaiDuMap
{
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL okay = [_mapManager start:@"AHOuEkh1P36zmR6zG8pVy6DHq8K6Ie33"
                  generalDelegate:nil];
    
    if (okay){
        LQCDLog(@"百度地图授权成功");
    }else{
        LQCDLog(@"百度地图授权失败");
    }
}



@end
