//
//  RootTabbar.h
//  sdfd
//
//  Created by 梁齐才 on 16/12/5.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootTabbar;
@protocol RootTabbarDelegate <NSObject>


@optional
- (void)rootTabbar:(RootTabbar *)tabar
   didClickedIndex:(NSInteger)index;

@end


@interface RootTabbar : XIBView<RootTabbarDelegate>

@property (nonatomic,weak) id <RootTabbarDelegate>delegate;

+ (CGFloat )expectedHeight;

- (void)selectItemAtIndex:(NSInteger)index;

@end



