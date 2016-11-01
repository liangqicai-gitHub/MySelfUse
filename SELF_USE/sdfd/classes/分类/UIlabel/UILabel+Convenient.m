//
//  UILabel+Convenient.m
//  kartor3
//
//  Created by 梁齐才 on 16/11/1.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "UILabel+Convenient.h"

@implementation UILabel (Convenient)


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           font:(CGFloat )fontSize
{
    return [self labelWithTextColor:textColor
                               font:fontSize
                        lineNumbers:1
                      textAlignment:NSTextAlignmentLeft
                      lineBreakMode:NSLineBreakByTruncatingTail
                     backGroudColor:nil];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           font:(CGFloat )fontSize
                    lineNumbers:(NSInteger)lineNumbers
{
    return [self labelWithTextColor:textColor
                               font:fontSize
                        lineNumbers:lineNumbers
                      textAlignment:NSTextAlignmentLeft
                      lineBreakMode:NSLineBreakByTruncatingTail
                     backGroudColor:nil];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           font:(CGFloat )fontSize
                    lineNumbers:(NSInteger)lineNumbers
                  textAlignment:(NSTextAlignment)textAlignment
{
    return [self labelWithTextColor:textColor
                               font:fontSize
                        lineNumbers:lineNumbers
                      textAlignment:textAlignment
                      lineBreakMode:NSLineBreakByTruncatingTail
                     backGroudColor:nil];
}


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           font:(CGFloat )fontSize
                    lineNumbers:(NSInteger)lineNumbers
                  textAlignment:(NSTextAlignment)textAlignment
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self labelWithTextColor:textColor
                               font:fontSize
                        lineNumbers:lineNumbers
                      textAlignment:textAlignment
                      lineBreakMode:lineBreakMode
                     backGroudColor:nil];
}


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           font:(CGFloat )fontSize
                    lineNumbers:(NSInteger)lineNumbers
                  textAlignment:(NSTextAlignment)textAlignment
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                 backGroudColor:(UIColor *)backGroudColor
{
    UILabel *label = [[UILabel alloc] init];
    if ([textColor isKindOfClass:[UIColor class]]){
        label.textColor = textColor;
    }
    
    if (fontSize <= 0) fontSize = 1;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    label.font = font;
    
    if (lineNumbers < 0) lineNumbers = 0;
    label.numberOfLines = lineNumbers;
    
    label.textAlignment = textAlignment;
    
    label.lineBreakMode = lineBreakMode;
    
    if ([backGroudColor isKindOfClass:[UIColor class]]){
        label.backgroundColor = backGroudColor;
    }else{
        label.backgroundColor = [UIColor clearColor];
    }
    
    return label;
}

@end
