//
//  RootBarItem.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootBarItem.h"


@interface RootBarItem ()

@property (weak, nonatomic) IBOutlet UIImageView *limageView;
@property (weak, nonatomic) IBOutlet UILabel *llabel;

@end


@implementation RootBarItem


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selected = NO;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
        
    UIColor *textColor = _normalTitleColor;
    UIImage *image = _normalImage;
    if (self.selected){
        textColor = _selectedTitleColor;
        image = _selectedImage;
    }
    [_llabel setTextColor:textColor];
    _llabel.text = _title;
    _limageView.image = image;
}

- (IBAction)btnClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didClickedInrootBarItem:)]){
        [_delegate didClickedInrootBarItem:self];
    }
}


@end
