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

//判断是不是空串
+ (BOOL)isEmptyString:(NSString *)string;

//document目录
+ (NSString *)documentsDirectory;


+ (NSString *)mainBundelResourcePath:(NSString *)resourceName;

//去掉空格
- (NSString *)trimString;

//计算高度
- (CGSize)sizeForFont:(UIFont *)font
                 size:(CGSize)size
                 mode:(NSLineBreakMode)lineBreakMode;


//子串出现的所有range 从左到右排列
- (NSArray<NSValue *> *)rangesOfString:(NSString *)searchString;

@end
