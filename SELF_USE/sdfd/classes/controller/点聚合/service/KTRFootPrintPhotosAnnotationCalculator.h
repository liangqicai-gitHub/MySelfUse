//
//  KTRFootPrintPhotosAnnotationCalculator.h
//  kartor3
//
//  Created by 梁齐才 on 16/10/25.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKClusterManager.h"

@class KTRFootPrintPhotosAnnotation;
@class KTRFootPrintPhotosModel;

typedef void(^calculateClustersCompleteBlock)(NSArray <KTRFootPrintPhotosAnnotation *>* annotations);

@interface KTRFootPrintPhotosAnnotationCalculator : NSObject

/*
 计算这个聚合点比较耗时，故而开一个异步线程去做这个事情
 如果models非法，或者为空，会回调一个nil
 回调的block在主线程
 */
+ (void)getClustersWithModels:(NSArray <KTRFootPrintPhotosModel *>*)models
                    zoomLevel:(CGFloat)zoomLevel
                completeBlock:(calculateClustersCompleteBlock)completeBlock;


@end


@interface KTRBMKClusterItem : BMKClusterItem

@property (nonatomic,strong) NSObject *businessModel;

@end
