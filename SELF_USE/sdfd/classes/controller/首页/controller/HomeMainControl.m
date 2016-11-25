//
//  HomeControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "HomeMainControl.h"
#import "testButtonVC.h"

@interface HomeMainControl ()


@end

@implementation HomeMainControl


- (NSString *)title
{
    return @"首页";
}


- (IBAction)testButtonLayout:(UIButton *)sender
{
    
    [self pushTo:[[testButtonVC alloc] init] animation:YES];
}



@end
