//
//  RootTabbarItem.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootTabbarItem.h"

@interface RootTabbarItem ()

@property (weak, nonatomic) IBOutlet UIImageView *limageView;
@property (nonatomic, weak, nonatomic) IBOutlet UILabel *llabel;


@property (strong,nonatomic) UIColor *normalTextColor;
@property (strong,nonatomic) UIColor *selecteTextColor;
@property (strong,nonatomic) UIImage *normalImage;
@property (strong,nonatomic) UIImage *selectedImage;


@end




@implementation RootTabbarItem


+ (RootTabbarItem *)itemWithTitle:(NSString *)title
                  NormalTextColor:(UIColor *)normalTextColor
                selectedTextColor:(UIColor *)selectedTextColor
                      normalImage:(UIImage *)normalImage
                    selectedImage:(UIImage *)selectedImage;
{
    RootTabbarItem *item = [[NSBundle mainBundle] loadNibNamed:@"RootTabbarItem" owner:nil options:nil][0];
    item.translatesAutoresizingMaskIntoConstraints = NO;
   
    item.normalTextColor = normalTextColor;
    item.selecteTextColor = selectedTextColor;
    item.normalImage = normalImage;
    item.selectedImage = selectedImage;
    
    NSString *newTitle = [NSString isEmptyString:title] ? @"" : title;
    item.llabel.text = newTitle;
    
    [item setSelected:NO];
    return item;
}



- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (_selected){
        [_limageView setImage:_selectedImage];
        [_llabel setTextColor:_selecteTextColor];
    }else{
        [_limageView setImage:_normalImage];
        [_llabel setTextColor:_normalTextColor];
    }
}



- (IBAction)clickButton:(UIButton *)sender
{
    if (_selected) return;
    if (!_delegate) return;
    if (![_delegate respondsToSelector:@selector(didSelected:)]) return;
    [_delegate didSelected:self];
}




@end
