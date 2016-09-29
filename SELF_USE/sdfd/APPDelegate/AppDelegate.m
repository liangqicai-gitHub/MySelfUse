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

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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




@end
