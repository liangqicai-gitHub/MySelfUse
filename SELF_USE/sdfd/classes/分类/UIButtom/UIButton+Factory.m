//
//  UIButton+Factory.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "UIButton+Factory.h"

@implementation UIButton (Factory)


+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
                       normalImage:(UIImage *)normalImage
{
    return [self newInstanceWithTitle:title
                                 font:font
                     normalTitleColor:normalTitleColor
                  highlightTitleColor:nil
                   selectedTitleColor:nil
                    disableTitleColor:nil
                  horizontalAlignment:UIControlContentHorizontalAlignmentCenter
                    verticalAlignment:UIControlContentVerticalAlignmentCenter
                          normalImage:normalImage
                       highlightImage:nil
                        selectedImage:nil
                         disableImage:nil];
}

+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                       normalImage:(UIImage *)normalImage
{
    return [self newInstanceWithTitle:title
                                 font:font
                     normalTitleColor:normalTitleColor
                  highlightTitleColor:nil
                   selectedTitleColor:nil
                    disableTitleColor:nil
                  horizontalAlignment:horizontalAlignment
                    verticalAlignment:UIControlContentVerticalAlignmentCenter
                          normalImage:normalImage
                       highlightImage:nil
                        selectedImage:nil
                         disableImage:nil];
}

+ (UIButton *)newInstanceWithTitle:(NSString *)title
                              font:(UIFont *)font
                  normalTitleColor:(UIColor *)normalTitleColor
               highlightTitleColor:(UIColor *)highlightTitleColor
                       normalImage:(UIImage *)normalImage
                    highlightImage:(UIImage *)highlightImage
{
    return [self newInstanceWithTitle:title
                                 font:font
                     normalTitleColor:normalTitleColor
                  highlightTitleColor:highlightTitleColor
                   selectedTitleColor:nil
                    disableTitleColor:nil
                  horizontalAlignment:UIControlContentHorizontalAlignmentCenter
                    verticalAlignment:UIControlContentVerticalAlignmentCenter
                          normalImage:normalImage
                       highlightImage:highlightImage
                        selectedImage:nil
                         disableImage:nil];
}




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
                      disableImage:(UIImage *)disableImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    
    [button UI_setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button UI_setTitleColor:highlightTitleColor forState:UIControlStateHighlighted];
    [button UI_setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [button UI_setTitleColor:disableTitleColor forState:UIControlStateDisabled];
    
    button.contentHorizontalAlignment = horizontalAlignment;
    button.contentVerticalAlignment = verticalAlignment;
    
    [button UF_setImage:normalImage forState:UIControlStateNormal];
    [button UF_setImage:highlightImage forState:UIControlStateHighlighted];
    [button UF_setImage:selectedImage forState:UIControlStateSelected];
    [button UF_setImage:disableImage forState:UIControlStateDisabled];
    
    return button;
}


- (void)UF_setImage:(UIImage *)image forState:(UIControlState)state
{
    if (![image isKindOfClass:[UIImage class]]) return;
    [self setImage:image forState:state];
}

- (void)UI_setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    if (![color isKindOfClass:[UIColor class]]) return;
    [self setTitleColor:color forState:state];
}


@end
