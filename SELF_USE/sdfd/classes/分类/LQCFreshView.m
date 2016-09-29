//
//  LQCFreshView.m
//  sdfd
//
//  Created by 梁齐才 on 16/6/12.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "LQCFreshView.h"


@interface LQCFreshView ()

@property (assign) FreshType type;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UIView *animationImage;
@property (weak, nonatomic) IBOutlet UIImageView *outterImage;
@property (weak, nonatomic) IBOutlet UIImageView *innerImage;
@end


@implementation LQCFreshView


+ (LQCFreshView *)instanceWithType:(FreshType)type
{
    LQCFreshView *view = [[NSBundle mainBundle] loadNibNamed:@"LQCFreshView" owner:nil options:nil][0];
    view.animationImage.hidden = YES;
    view.type = type;
    if (type == FreshType_Header){
        view.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return view;
}


- (void)setNormalState
{
    [self stopAnim];
    _animationImage.hidden = YES;
    _arrowImage.hidden = NO;
    
    NSString *normalTile = @"下拉刷新";
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI);
    if (_type == FreshType_Footer){
        normalTile = @"上拉加载更多";
        trans = CGAffineTransformIdentity;
    }
    _infoLabel.text = normalTile;
    
    [UIView animateWithDuration:0.25 animations:^{
        _arrowImage.transform = trans;
    }];
}


- (void)setPullingState
{
    [self stopAnim];
    _animationImage.hidden = YES;
    _arrowImage.hidden = NO;
    
    NSString *normalTile = @"松手刷新";
    CGAffineTransform trans = CGAffineTransformIdentity;
    if (_type == FreshType_Footer){
        normalTile = @"松手加载更多";
        trans = CGAffineTransformMakeRotation(M_PI);
    }
    _infoLabel.text = normalTile;
    
    [UIView animateWithDuration:0.25 animations:^{
        _arrowImage.transform = trans;
    }];
}


- (void)setFreshingState
{
    [self startAnim];
    _infoLabel.text = @"加载中...";
    _animationImage.hidden = NO;
    _arrowImage.hidden = YES;
}



- (void)startAnim
{
    [self stopAnim];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.toValue = @(2 * M_PI);
    anim.repeatCount = HUGE_VALF;
    anim.removedOnCompletion = NO;
    anim.duration = 1.0;
    [[_outterImage layer] addAnimation:anim forKey:@"out"];
    
    
    anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.toValue = @(-2 * M_PI);
    anim.repeatCount = HUGE_VALF;
    anim.removedOnCompletion = NO;
    anim.duration = 1.0;
    [[_innerImage layer] addAnimation:anim forKey:@"inner"];
    
}

- (void)stopAnim
{
    [[_outterImage layer] removeAnimationForKey:@"outter"];
    [[_innerImage layer] removeAnimationForKey:@"inner"];
}


@end
