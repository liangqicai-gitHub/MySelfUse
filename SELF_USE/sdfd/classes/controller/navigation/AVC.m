//
//  AVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/22.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "AVC.h"
#import "BVC.h"

@interface AVC ()

@end

@implementation AVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)title
{
    return @"A";
}


- (BOOL)navigationBarHidden
{
    return YES;
}

- (IBAction)ss:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[BVC alloc] init] animated:YES];
}

@end
