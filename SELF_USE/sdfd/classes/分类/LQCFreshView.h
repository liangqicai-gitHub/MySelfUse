//
//  LQCFreshView.h
//  sdfd
//
//  Created by 梁齐才 on 16/6/12.
//  Copyright © 2016年 梁齐才. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FreshType_Header,
    FreshType_Footer,
} FreshType;

@interface LQCFreshView : UIView

+ (LQCFreshView *)instanceWithType:(FreshType)type;

- (void)setNormalState;

- (void)setPullingState;

- (void)setFreshingState;

@end
