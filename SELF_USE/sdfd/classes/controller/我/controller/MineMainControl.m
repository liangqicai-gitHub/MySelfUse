//
//  MineMainControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "MineMainControl.h"
#import "TestKeyBoradVC.h"


@interface MineMainControl ()



@end

@implementation MineMainControl



- (IBAction)toTestKeyBorad:(UIButton *)sender {
    
    TestKeyBoradVC *vc = [[TestKeyBoradVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
