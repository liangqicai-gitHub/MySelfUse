//
//  DiscoverMainViewControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "DiscoverMainViewControl.h"
#import "MineMainControl.h"


@interface DiscoverMainViewControl ()


@end

@implementation DiscoverMainViewControl

- (IBAction)ddfa:(UIButton *)sender {
    
    MineMainControl *vc = [[MineMainControl alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
