//
//  NSArray+Usual.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "NSArray+Usual.h"

@implementation NSArray (Usual)

+ (BOOL)isEmpty:(id)sender
{
    if (![sender isKindOfClass:[NSArray class]]){
        return YES;
    }
    
    return [(NSArray *)sender count] == 0;
}


+ (BOOL)  isArray:(id)sender
equalOrLongerThan:(NSInteger)count
{
    if (![sender isKindOfClass:[NSArray class]]) return NO;
    
    return [sender count] >= count;
}


- (id)safeObjAtIndex:(NSUInteger)index
{
    NSInteger count = self.count;
    if (count > index){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}


@end
