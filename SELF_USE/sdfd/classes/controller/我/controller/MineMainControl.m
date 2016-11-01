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
#import "histroyTrackVC.h"
#import "PortraitPlayerController.h"
#import "FootprintTestVC.h"

@interface MineMainControl ()

@end

@implementation MineMainControl

- (IBAction)toTestKeyBorad:(UIButton *)sender
{
    [self testFootPrint];
//    [self testHis];
//    [self testBaiDuMapClusterFunction];
//    [self testIOS8CellSelfCalculate];
//    [self testAVPlayer];
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
//测试历史轨迹的cell
- (void)testHis
{
    histroyTrackVC *vc = [[histroyTrackVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//测试爱奇艺横屏例子
- (void)testAVPlayer
{
    PortraitPlayerController *vc = [[PortraitPlayerController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//测试驾图足迹列表
- (void)testFootPrint
{
    FootprintTestVC *vc = [[FootprintTestVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
