//
//  NSObject+Usual.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "NSObject+Usual.h"

@implementation NSObject (Usual)


+ (BOOL)isNullObject:(id)sender
{
    if (sender == nil) return YES;
    if ([sender isEqual:[NSNull null]]) return YES;
    return NO;
}

@end
