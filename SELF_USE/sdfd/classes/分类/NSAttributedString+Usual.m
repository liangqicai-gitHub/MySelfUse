//
//  NSAttributedString+Usual.m
//  sdfd
//
//  Created by 梁齐才 on 16/6/3.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "NSAttributedString+Usual.h"

@implementation NSAttributedString (Usual)


- (CGFloat)expectHeight:(CGFloat)labelWidth
{
    CGRect stringMSize = [self boundingRectWithSize:(CGSize){labelWidth,CGFLOAT_MAX}
                                            options:(NSStringDrawingTruncatesLastVisibleLine |
                                                     NSStringDrawingUsesLineFragmentOrigin |
                                                     NSStringDrawingUsesFontLeading)
                                            context:nil];
    
    return CGRectGetHeight(stringMSize);
}


@end
