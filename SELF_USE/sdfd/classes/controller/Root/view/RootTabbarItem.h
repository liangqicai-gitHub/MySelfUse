//
//  RootTabbarItem.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootTabbarItem;
@protocol RootTabbarItemDelegate <NSObject>

- (void)didSelected:(RootTabbarItem *)item;

@end



@interface RootTabbarItem : UIView


@property (assign,nonatomic) BOOL selected;

@property (weak,nonatomic) id <RootTabbarItemDelegate> delegate;


+ (RootTabbarItem *)itemWithTitle:(NSString *)title
                  NormalTextColor:(UIColor *)normalTextColor
                selectedTextColor:(UIColor *)selectedTextColor
                      normalImage:(UIImage *)normalImage
                    selectedImage:(UIImage *)selectedImage;


@end
