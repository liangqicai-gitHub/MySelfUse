//
//  KTRFootPrintPhotosAnnotation.m
//  kartor3
//
//  Created by 梁齐才 on 16/10/25.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosAnnotation.h"
#import "KTRFootPrintPhotosModel.h"

@implementation KTRFootPrintPhotosAnnotation

- (void)setModels:(NSArray<KTRFootPrintPhotosModel *> *)models
{
//    if ([KTRHelper isEmptyArray:models]) return;
    if ([NSArray isEmpty:models]) return;
    _models = models;
    
    KTRFootPrintPhotosModel *fristModel = models[0];
    if ([fristModel isKindOfClass:[KTRFootPrintPhotosModel class]]){
        self.coordinate = fristModel.coordinate;
        NSLog(@"set  %f   %f",fristModel.coordinate.latitude,fristModel.coordinate.longitude);
    }
}

@end

