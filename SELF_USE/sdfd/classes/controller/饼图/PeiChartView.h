//
//  PeiChartView
//  sdfd
//
//  Created by 梁齐才 on 17/1/10.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PieChartItem : NSObject

@property (nonatomic,strong) UIColor *color;
@property (assign) CGFloat number;

@end



@interface PeiChartView : UIView

@property (assign) CGFloat ringWidth;
@property (assign) CGFloat itemsSpace;
@property (assign) CGFloat smallestItemValue;

@property (nonatomic,strong) NSArray <PieChartItem *>* items;

- (void)showWithAnimations:(BOOL)animations;

@end
