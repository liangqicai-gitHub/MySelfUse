//
//  RootTabbar.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootTabbar;
@protocol RootTabbarDelegate <NSObject>

@optional

- (void)rootTabbarView:(RootTabbar *)tabbar didSelectIndex:(NSInteger)index;

@end


@class RootTabbarItem;
@interface RootTabbar : UIView

@property (nonatomic,weak) id <RootTabbarDelegate> delegate;

/**
 *  因为不能直接在UITabbar上添加约束，所以只能用frame这种方式。
 *  我会给你一个  RootTabbar   上面添加的是另外一个view
 *
 */
+ (RootTabbar *)rootTabbarWithFrame:(CGRect)frame;

- (void)addItem:(RootTabbarItem *)item;

//调用这个方法，并不会出发代理
- (void)setSelectedIndex:(NSInteger)index;

@end
