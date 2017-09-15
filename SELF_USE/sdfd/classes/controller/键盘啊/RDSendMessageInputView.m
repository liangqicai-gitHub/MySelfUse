//
//  RDSendMessageInputView.m
//  sdfd
//
//  Created by 梁齐才 on 17/8/11.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RDSendMessageInputView.h"
#import "UIView+SeparateLine.h"

@interface RDSendMessageInputView ()
{
    UIButton *_emojiBtn;
    UIButton *_keyboardBtn;
    UIButton *_imgBtn;
    UIButton *_sendBtn;
    
    CGFloat _topImagesBtnWidth;
    CGFloat _topImagesBtnHeight;
    CGFloat _topSendBtnWidth;
}


@end


@implementation RDSendMessageInputView

- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
        [self initViews];
    }
    return self;
}

- (void)initVars
{
    _topImagesBtnWidth = 33.0;
    _topImagesBtnHeight = 33.0;
//    _topSendBtnWidth = 
    
    _emojiBtn = [[UIButton alloc] init];
    [_emojiBtn setImage:KImg(@"ip-top-emoji") forState:UIControlStateNormal];
    
    _imgBtn = [[UIButton alloc] init];
    [_imgBtn setImage:KImg(@"ip-top-img") forState:UIControlStateNormal];
    
    
}

- (void)initViews
{
    [self drawTopLine:0 right:0];
    
    
    
}


@end
