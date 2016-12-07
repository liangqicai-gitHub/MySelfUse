//
//  RootBarItem.h
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RootBarItem : UIControl

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBInspectable UIImage *selectedImage;
@property (strong, nonatomic) IBInspectable UIImage *normalImage;
@property (strong, nonatomic) IBInspectable NSString *title;
@property (strong, nonatomic) IBInspectable UIColor *normalTitleColor;
@property (strong, nonatomic) IBInspectable UIColor *selectedTitleColor;


@end
