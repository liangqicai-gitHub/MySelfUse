//
//  RootBarItem.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootBarItem.h"


@interface RootBarItem ()

@property (strong, nonatomic) UIImageView *limageView;
@property (strong, nonatomic) UILabel *llabel;

@end


@implementation RootBarItem


+ (RootBarItem *)instanceWithSelectedImage:(UIImage *)selectedImage
                               normalImage:(UIImage *)normalImage
                                     title:(NSString *)title
                          normalTitleColor:(UIColor *)normalTitleColor
                        selectedTitleColor:(UIColor *)selectedTitleColor
{
    RootBarItem *item = [[RootBarItem alloc]
                         initWithSelectedImage:selectedImage
                         normalImage:normalImage title:title
                         normalTitleColor:normalTitleColor
                         selectedTitleColor:selectedTitleColor];
    
    return item;
}

- (instancetype)initWithSelectedImage:(UIImage *)selectedImage
                          normalImage:(UIImage *)normalImage
                                title:(NSString *)title
                     normalTitleColor:(UIColor *)normalTitleColor
                   selectedTitleColor:(UIColor *)selectedTitleColor
{
    self = [self init];
    if (self){
        _selectedImage = selectedImage;
        _normalImage = normalImage;
        _title = title;
        _normalTitleColor = normalTitleColor;
        _selectedTitleColor = selectedTitleColor;
    }
    [self setSelected:NO];
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self){
        [self initViews];
    }
    return self;
}


- (void)initViews
{
    _limageView = [[UIImageView alloc] init];
    [self addSubview:_limageView];
    
    [_limageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.centerX.mas_equalTo(0);
    }];
    
    
    _llabel = [UILabel labelWithTextColor:[UIColor lightGrayColor]
                                     font:10
                              lineNumbers:1
                            textAlignment:NSTextAlignmentCenter];
    [self addSubview:_llabel];
    [_llabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_limageView.mas_bottom).offset(3);
        make.centerX.mas_equalTo(0);
    }];
}



#pragma mark - setter

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
        
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


@end
