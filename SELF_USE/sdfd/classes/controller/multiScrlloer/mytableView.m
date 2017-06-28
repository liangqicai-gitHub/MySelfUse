//
//  mytableView.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/15.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "mytableView.h"

@implementation mytableView



- (UIView *)hitTest:(CGPoint)point
          withEvent:(UIEvent *)event
{
    LQCDLog(@"dsfadsf");
    return [super hitTest:point withEvent:event];
}


@end
