//
//  LQCPhotoBrowseCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/3.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "LQCPhotoBrowseCell.h"
#import "LQCPhotoBrowseModel.h"


@interface LQCPhotoBrowseCell ()<UIScrollViewDelegate>
{
    UILabel *_percentageLabel;
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}

@end


@implementation LQCPhotoBrowseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initViews];
    }
    return self;
}


- (void)initViews
{
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    
    _percentageLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_percentageLabel];
    _percentageLabel.text = @"20%";
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_scrollView setFrame:self.bounds];
    [_imageView setFrame:CGRectMake(0, 0, 150, 80)];
    [_imageView setCenter:_scrollView.center];
    [_imageView setImage:[UIImage imageNamed:@"root_tabar_02_ss"]];
    [_percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointZero);
    }];
}



-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize calculateSize = scrollView.contentSize;
    if (calculateSize.width < scrollView.frame.size.width){
        calculateSize.width = scrollView.frame.size.width;
    }
    
    if (calculateSize.height < scrollView.frame.size.height){
        calculateSize.height = scrollView.frame.size.height;
    }
    _imageView.center = CGPointMake(calculateSize.width / 2.0f, calculateSize.height / 2.0f);
}



- (void)setModel:(LQCPhotoBrowseModel *)model
{
    _model = model;
}




@end
