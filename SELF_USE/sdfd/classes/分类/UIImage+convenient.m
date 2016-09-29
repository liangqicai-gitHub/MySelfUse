//
//  UIImage+convenient.m
//  sdfd
//
//  Created by 梁齐才 on 16/8/19.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "UIImage+convenient.h"

@implementation UIImage (convenient)




//横向拉伸哈。。。。这就是个例子，有纵向拉伸的时候，自己再参照写
+ (UIImage *)resizeImage:(UIImage *)orignImage toSize:(CGSize)toSize
{
    CGFloat DWidth = toSize.width - orignImage.size.width;
    if (DWidth <= 0) return orignImage;
    
    //第一次拉伸
    CGFloat stretch = 0.9;
    UIImage *tempeImage = [orignImage stretchableImageWithLeftCapWidth:orignImage.size.width *stretch topCapHeight:orignImage.size.height *0.5];
    
    NSInteger halfDWidth = DWidth / 2;//这个地方，如果你不转成整数  就可能出现 222.46   这种就会造成画图 画了一张有边线的图
    CGFloat fristWidth = orignImage.size.width + halfDWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(fristWidth, toSize.height), NO, [UIScreen mainScreen].scale);
    [tempeImage drawInRect:CGRectMake(0, 0, fristWidth, toSize.height)];
    UIImage *tempEndImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    /*
     现在就把图片尖尖的位置在  orignImage.size.width / 2
     而 tempEndImage 的长度是 orignImage.size.width + (Dwidth / 2.0f)
     tempEndImage 的中心在尖尖的右边的 (fristWidth / 2.0f) - (orignImage.size.width / 2)
     所以现在应该从  (fristWidth / 2.0f)
     */
    return [tempEndImage stretchableImageWithLeftCapWidth:orignImage.size.width * 0.1 topCapHeight:orignImage.size.height *0.5];
}





@end
