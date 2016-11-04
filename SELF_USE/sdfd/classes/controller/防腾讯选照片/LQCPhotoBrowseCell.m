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
{
    UILabel *_label;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end


@implementation LQCPhotoBrowseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor blackColor];
    _scrollView.minimumZoomScale = 1.0f;
    _scrollView.maximumZoomScale = 10.0f;
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
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
    _label.frame = CGRectMake(0, 0, 100, 100);
    [_label setCenter:_scrollView.center];
}


- (void)setLabelText:(NSString *)labelText
{
    _label.text = labelText;
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

//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"");
//}
//
//
//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
//{
//    NSLog(@"_imageView.Size %@",NSStringFromCGSize(_imageView.frame.size));
//    NSLog(@"width / 150 == %f",_imageView.frame.size.width / 150.f);
//    NSLog(@"height / 80 == %f",_imageView.frame.size.height / 80.0f);
//    NSLog(@"========== scale = %f",scale);
//    
//    NSLog(@"scrollView frame %@",NSStringFromCGRect(scrollView.frame));
//    NSLog(@"scrollView contentSize %@",NSStringFromCGSize(scrollView.contentSize));
//    
//}



- (void)prepareForReuse
{
    [super prepareForReuse];
    _scrollView.zoomScale = 1.0f;
}

@end
