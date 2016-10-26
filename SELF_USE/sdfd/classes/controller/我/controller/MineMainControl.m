//
//  MineMainControl.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "MineMainControl.h"
#import "iOS8CellSelfCalculate.h"
#import "BaiduMapClusterTest.h"

@interface MineMainControl ()

@end

@implementation MineMainControl

- (IBAction)toTestKeyBorad:(UIButton *)sender
{
    [self testBaiDuMapClusterFunction];
//    [self testIOS8CellSelfCalculate];
}

//测试iOS8 cell高度子计算
- (void)testIOS8CellSelfCalculate
{
    iOS8CellSelfCalculate *vc = [[iOS8CellSelfCalculate alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//测试百度地图点聚合
- (void)testBaiDuMapClusterFunction
{
    BaiduMapClusterTest *vc = [[BaiduMapClusterTest alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
