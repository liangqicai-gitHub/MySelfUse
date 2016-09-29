//
//  NSString+Usual.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Str_F(...) [NSString stringWithFormat:__VA_ARGS__]


@interface NSString (Usual)


+ (BOOL)isEmptyString:(NSString *)string;


+ (NSString *)documentsDirectory;


- (NSString *)trimString;


// only in ios7 later  and your label's LineBreakMode should not be setted as  
- (CGFloat)expectHeight:(CGFloat)labelWidth font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;



- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

@end
