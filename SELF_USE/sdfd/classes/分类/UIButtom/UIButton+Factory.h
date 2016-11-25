//
//  UIButton+Factory.h
//  sdfd
//
//  Created by 梁齐才 on 16/11/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Factory)

/*
 仅初始化，不布局。
 推荐外部布局。
 */

+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
                       normalImage:(UIImage *)normalImage;

+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                       normalImage:(UIImage *)normalImage;

+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               highlightTitleColor:(UIColor *)highlightTitleColor
                       normalImage:(UIImage *)normalImage
                    highlightImage:(UIImage *)highlightImage;




+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               highlightTitleColor:(UIColor *)highlightTitleColor
                selectedTitleColor:(UIColor *)selectedTitleColor
                 disableTitleColor:(UIColor *)disableTitleColor
               horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                 verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                       normalImage:(UIImage *)normalImage
                    highlightImage:(UIImage *)highlightImage
                     selectedImage:(UIImage *)selectedImage
                      disableImage:(UIImage *)disableImage;


@end
