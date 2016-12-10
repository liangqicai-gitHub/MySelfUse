//
//  RootBarItem.h
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootBarItem : UIControl

@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIImage *normalImage;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *normalTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;


- (instancetype)initWithSelectedImage:(UIImage *)selectedImage
                          normalImage:(UIImage *)normalImage
                                title:(NSString *)title
                     normalTitleColor:(UIColor *)normalTitleColor
                   selectedTitleColor:(UIColor *)selectedTitleColor;


+ (RootBarItem *)instanceWithSelectedImage:(UIImage *)selectedImage
                               normalImage:(UIImage *)normalImage
                                     title:(NSString *)title
                          normalTitleColor:(UIColor *)normalTitleColor
                        selectedTitleColor:(UIColor *)selectedTitleColor;


@end
