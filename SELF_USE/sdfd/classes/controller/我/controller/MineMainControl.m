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
#import "PortraitPlayerController.h"
#import "FootprintTestVC.h"
#import "LQCPhotoBrowseController.h"
#import "LQCPhotoBrowseModel.h"
#import <SDWebImage/SDWebImageManager.h>
#import "TestForCollectionView.h"
#import "APLViewController.h"
#import "SocketClient.h"
#import "HTTPManager.h"
#import "ChartVC.h"



@interface MineMainControl ()



@end

@implementation MineMainControl


- (NSString *)title
{
    return @"我";
}


- (IBAction)toTestKeyBorad:(UIButton *)sender
{
    BaiduMapClusterTest *vc = [[BaiduMapClusterTest alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)chart:(UIButton *)sender
{
    ChartVC *vc = [[ChartVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

//测试选照片
- (void)testPhotoBrose
{
    LQCPhotoBrowseController *vc = [[LQCPhotoBrowseController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



#pragma mark - LQCPhotoBrowseSetImageDelegate

- (void)LQCPB_asynFetchImageWithPath:(NSURL *)imagePath
                            progress:(void (^)(NSInteger, NSInteger))progressBlock
                            complete:(void (^)(UIImage *, NSError *, NSURL *))completeBlock
{
 
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager
     downloadImageWithURL:imagePath
     options:SDWebImageLowPriority
     progress:progressBlock
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         if (completeBlock) completeBlock(image,error,imageURL);
    }];
}


- (void)testCollectionView
{
    TestForCollectionView *vc = [[TestForCollectionView alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
