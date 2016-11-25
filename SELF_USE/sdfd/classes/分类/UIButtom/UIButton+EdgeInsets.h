//
//  UIButton+imageTitleLayout.h
//  
//
//  Created by 韩保玉 on 15/6/28.
//  Copyright (c) 2015年 韩保玉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (EdgeInsets) 

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitlespace:(CGFloat)space;


+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               highlightTitleColor:(UIColor *)highlightTitleColor
                selectedTitleColor:(UIColor *)selectedTitleColor
                 disableTitleColor:(UIColor *)selectedTitleColor
               horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                 verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                       normalImage:(UIImage *)normalImage
                    highlightImage:(UIImage *)highlightImage
                     selectedImage:(UIImage *)selectedImage
                      disableImage:(UIImage *)disableImage;

@end
