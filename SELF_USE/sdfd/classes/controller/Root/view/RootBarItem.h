//
//  RootBarItem.h
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@class RootBarItem;
@protocol RootBarItemDelegate <NSObject>

- (void)didClickedInrootBarItem:(RootBarItem *)item;

@end

@interface RootBarItem : XIBView

@property (assign, nonatomic) IBOutlet id <RootBarItemDelegate>delegate;

@property (assign, nonatomic) IBInspectable BOOL selected;
@property (strong, nonatomic) IBInspectable UIImage *selectedImage;
@property (strong, nonatomic) IBInspectable UIImage *normalImage;
@property (strong, nonatomic) IBInspectable NSString *title;
@property (strong, nonatomic) IBInspectable UIColor *normalTitleColor;
@property (strong, nonatomic) IBInspectable UIColor *selectedTitleColor;

@end
