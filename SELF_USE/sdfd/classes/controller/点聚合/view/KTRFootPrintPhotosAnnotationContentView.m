//
//  KTRFootPrintPhotosAnnotationContentView.m
//  kartor3
//  Created by 梁齐才 on 2016/10/17.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosAnnotationContentView.h"


@interface KTRFootPrintPhotosAnnotationContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *lphotoBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lphotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lphotoNumberBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *lphotoNumberLabel;

@end

@implementation KTRFootPrintPhotosAnnotationContentView

#pragma mark - 初始化相关
+ (KTRFootPrintPhotosAnnotationContentView *)contentView
{
    KTRFootPrintPhotosAnnotationContentView *view =
    [[NSBundle mainBundle] loadNibNamed:@"KTRFootPrintPhotosAnnotationContentView"
                                  owner:nil
                                options:nil][0];
    view.backgroundColor = [UIColor clearColor];
    [view setFrame:CGRectZero];
    return view;
}

- (instancetype)init
{
    @throw @"请使用[KTRFootPrintPhotosAnnotationContentView contentView] 来new";
    return nil;
}

#pragma mark - frame相关

- (void)setFrame:(CGRect)frame
{
    CGRect newFrame = [KTRFootPrintPhotosAnnotationContentView fixedFrame];
    [super setFrame:newFrame];
}

- (CGRect)frame
{
    return [KTRFootPrintPhotosAnnotationContentView fixedFrame];
}

#pragma mark - setter

- (void)setImages:(NSArray *)images
{
//    if ([KTRHelper isEmptyArray:images])
    if ([NSArray isEmpty:images])
    {
        _images = [NSArray array];
    }else{
        _images = images;
    }
    
    NSInteger numbers = images.count;
    
    //数量背景图
    NSString *numberImageName = @"FP_PA_NumberBG1";
    if (numbers > 9) numberImageName = @"FP_PA_NumberBG1";
    UIImage *numberBGImage = [UIImage imageNamed:numberImageName];
    _lphotoNumberBgImageView.image = numberBGImage;
    
    //照片的背景图
    NSString *photoBGImageName = @"FP_PA_photoBG1";
    if (numbers > 1) photoBGImageName = @"FP_PA_photoBG2";
    UIImage *photoBGImage = [UIImage imageNamed:photoBGImageName];
    _lphotoBgImageView.image = photoBGImage;
    
    //设置数量的label
    NSString *numberDes = Str_F(@"%zd",numbers);
    if (numbers > 99) numberDes = @"99+";
    _lphotoNumberLabel.text = numberDes;
}


#pragma mark - 静态（类）方法

+ (CGRect)fixedFrame
{
    CGSize fixedSize = [self expectedSize];
    return CGRectMake(0.f, 0.f, fixedSize.width, fixedSize.height);
}

+ (CGSize)expectedSize
{
    return CGSizeMake(82.f, 92.f);
}


@end
