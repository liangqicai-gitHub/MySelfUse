//
//  NSArray+Usual.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Usual)


+ (BOOL)isEmpty:(id)sender;


+ (BOOL)  isArray:(id)sender
equalOrLongerThan:(NSInteger)count;

/**
 *  在取的时候，我会帮你判断是不是越界。
 *  
 *  如果你的index非法，我会给你 nil
 *
 *  @param index index
 *
 *  @return
 */
- (id)safeObjAtIndex:(NSUInteger)index;





@end
