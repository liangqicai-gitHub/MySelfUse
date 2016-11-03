//
//  LQCPhotoBrowseCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/3.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "LQCPhotoBrowseCell.h"

@interface LQCPhotoBrowseCell ()
<
UIScrollViewDelegate
>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end


@implementation LQCPhotoBrowseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _scrollView.minimumZoomScale = 1.0f;
    _scrollView.maximumZoomScale = 2.0f;
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if(scrollView.zoomScale <=1) scrollView.zoomScale = 1.0f;
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [_imageView setCenter:CGPointMake(xcenter, ycenter)];
}
@end
