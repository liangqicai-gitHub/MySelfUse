//
//  KTRFootPrintPhotosAnnotationContentView.h
//  kartor3
/*
 足迹点，（包含一张或多张照片）在地图上AnnotationView的具体的contentView
 */
//  Created by 梁齐才 on 2016/10/17.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTRFootPrintPhotosAnnotationContentView : UIView

+(KTRFootPrintPhotosAnnotationContentView *)contentView;

+ (CGSize)expectedSize;

@property (nonatomic,strong) NSArray *images;


@end
