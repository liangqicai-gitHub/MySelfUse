//
//  KTRFootPrintPhotosAnnotationView.m
//  kartor3
//
//  Created by 梁齐才 on 16/10/15.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosAnnotationView.h"
#import "KTRFootPrintPhotosAnnotationContentView.h"

@interface KTRFootPrintPhotosAnnotationView ()
{
    //view
    KTRFootPrintPhotosAnnotationContentView *_contentView;
    
    CGPoint _selfOffPoint;//这个AnnotationView的便宜量是固定的
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


@end
