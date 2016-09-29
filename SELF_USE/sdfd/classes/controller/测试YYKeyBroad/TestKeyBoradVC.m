//
//  TestKeyBoradVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/8/19.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "TestKeyBoradVC.h"
#import <YYKit/YYTextKeyboardManager.h>

@interface TestKeyBoradVC ()<YYTextKeyboardObserver>
{
    __weak YYTextKeyboardManager *_manager;
}

@end

@implementation TestKeyBoradVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _manager = [YYTextKeyboardManager defaultManager];
    
    [_manager addObserver:self];
    
}



- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition
{
    
    NSLog(@"view --- %@",_manager.keyboardView);
    
}

@end
