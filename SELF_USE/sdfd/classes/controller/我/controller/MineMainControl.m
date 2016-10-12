//
//  MineMainControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "MineMainControl.h"


#import "OpenURLTestVC.h"



@interface MineMainControl ()



@end

@implementation MineMainControl



- (IBAction)toTestKeyBorad:(UIButton *)sender {
    
    
    
    OpenURLTestVC *vc = [[OpenURLTestVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
