//
//  KTRFootPrintPhotosAnnotationCalculator.m
//  kartor3
//
//  Created by 梁齐才 on 16/10/25.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosAnnotationCalculator.h"
#import "KTRFootPrintPhotosModel.h"
#import "KTRFootPrintPhotosAnnotation.h"

@implementation KTRFootPrintPhotosAnnotationCalculator


+ (void)getClustersWithModels:(NSArray <KTRFootPrintPhotosModel *>*)models
                    zoomLevel:(CGFloat)zoomLevel
                completeBlock:(calculateClustersCompleteBlock)completeBlock
{
    if (!completeBlock) return;
//    if ([KTRHelper isEmptyArray:models])
    if ([NSArray isEmpty:models])
    {
        [self callBackCompleteBlock:completeBlock clusters:nil];
        return;
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BMKClusterManager *manager = [[BMKClusterManager alloc] init];
        [models enumerateObjectsUsingBlock:^(KTRFootPrintPhotosModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KTRBMKClusterItem *clusterItem = [[KTRBMKClusterItem alloc] init];
            clusterItem.coor = obj.coordinate;
            clusterItem.businessModel = obj;
            [manager addClusterItem:clusterItem];
        }];
        
        NSMutableArray *rsM = [NSMutableArray array];
        NSArray <BMKCluster *>* baiduCluster = [manager getClusters:zoomLevel];
        [baiduCluster enumerateObjectsUsingBlock:^(BMKCluster * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KTRFootPrintPhotosAnnotation *annotation = [[KTRFootPrintPhotosAnnotation alloc] init];
            NSMutableArray *modelsM = [NSMutableArray array];
            [obj.clusterItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [modelsM addObject:[(KTRBMKClusterItem *)obj businessModel]];
            }];
            annotation.models = modelsM;
            [rsM addObject:annotation];
        }];
        
        [self callBackCompleteBlock:completeBlock clusters:rsM];
    });    
}


+ (void)callBackCompleteBlock:(calculateClustersCompleteBlock)completeBlock
                     clusters:(NSArray<KTRFootPrintPhotosAnnotation *> *)clusters
{
    dispatch_async(dispatch_get_main_queue(), ^{
        completeBlock(clusters);
    });
}

@end



@implementation KTRBMKClusterItem


@end

