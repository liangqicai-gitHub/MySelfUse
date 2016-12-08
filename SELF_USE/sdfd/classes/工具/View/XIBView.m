//
//  XIBView.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/8.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "XIBView.h"

@interface XIBView ()
{
    UIView *_xibView_contentView;
}

@end


@implementation XIBView

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self){
        [self initialization:NO];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initialization:YES];
    }
    return self;
}

- (void)initialization:(BOOL)decoderInit
{
    NSString *className = NSStringFromClass([self class]);
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:className
                                                 owner:self
                                               options:nil];
    
    if ([NSArray isEmpty:arr]) return;
    
    _xibView_contentView = arr[0];
    [self addSubview:_xibView_contentView];
    [_xibView_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    if (decoderInit){
        _xibView_contentView.backgroundColor = self.backgroundColor;
    }else{
        self.backgroundColor = _xibView_contentView.backgroundColor;
    }
}

#pragma mark - overwrite

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    _xibView_contentView.backgroundColor = backgroundColor;
}




@end
