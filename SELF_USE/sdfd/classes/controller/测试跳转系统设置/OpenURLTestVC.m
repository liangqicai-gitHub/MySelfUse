//
//  OpenURLTestVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/9.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "OpenURLTestVC.h"

@interface OpenURLTestVC ()

@end

@implementation OpenURLTestVC

- (IBAction)openUrl:(UIButton *)sender
{
//    NSURL *url = [NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    [[UIApplication sharedApplication] openURL:url];

    
}

@end
