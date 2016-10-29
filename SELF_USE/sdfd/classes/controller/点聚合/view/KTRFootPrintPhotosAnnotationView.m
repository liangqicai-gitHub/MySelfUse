//
//  KTRFootPrintPhotosAnnotationView.m
//  kartor3
//
//  Created by 梁齐才 on 16/10/15.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosAnnotationView.h"
#import "KTRFootPrintPhotosAnnotationContentView.h"
#import "KTRFootPrintPhotosAnnotation.h"
#import "KTRFootPrintPhotosModel.h"

@interface KTRFootPrintPhotosAnnotationView ()
{
    //view
    KTRFootPrintPhotosAnnotationContentView *_contentView;
    
    //这个AnnotationView的便宜量是固定的
    CGPoint _offPoint;
}

@end

@implementation KTRFootPrintPhotosAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:reuseIdentifier];
    
    if (self){
        [self initVars];
        [self initViews];
    }
    
    return self;
}



- (void)initVars
{
    
}


- (void)initViews
{
    UIColor *clearColor = [UIColor clearColor];
    CGSize fullSize = [KTRFootPrintPhotosAnnotationContentView expectedSize];
    CGRect fullBounds = CGRectZero;
    fullBounds.size = fullSize;
    
    UIView *bgView = [[UIView alloc] initWithFrame:fullBounds];
    [self addSubview:bgView];
    self.backgroundColor = bgView.backgroundColor = clearColor;
    
    _contentView = [KTRFootPrintPhotosAnnotationContentView contentView];
    [bgView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    _contentView.images = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) return;
    
    id annotation = self.annotation;
    if (![annotation isKindOfClass:[KTRFootPrintPhotosAnnotation class]]) return;
    
    NSArray<KTRFootPrintPhotosModel *> *FootPrintPhotosModels =
    [(KTRFootPrintPhotosAnnotation *)annotation models];
    
    NSMutableArray *images = [NSMutableArray array];
    
    [FootPrintPhotosModels enumerateObjectsUsingBlock:^(KTRFootPrintPhotosModel * _Nonnull obj,
                                                        NSUInteger idx,
                                                        BOOL * _Nonnull stop)
    {
        if (![NSArray isEmpty:obj.imageUrls]){
            [images addObjectsFromArray:obj.imageUrls];
        }
        
    }];
    
    _contentView.images = images;
}

@end
