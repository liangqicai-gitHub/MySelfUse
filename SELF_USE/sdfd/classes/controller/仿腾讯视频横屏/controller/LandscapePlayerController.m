//
//  LandscapePlayerController.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/29.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "LandscapePlayerController.h"
#import "PlayerView.h"

@interface LandscapePlayerController ()
<PlayerViewDelegate>

@end

@implementation LandscapePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _playerView.delegate = self;
    [self.view addSubview:_playerView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
    _playerView.transform = transform;
    
    [UIView animateWithDuration:0.25 animations:^{
        _playerView.transform = CGAffineTransformIdentity;
    }];
}


#pragma mark - 横屏控制

- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - #pragma mark - PlayerViewDelegate


- (void)didClickedPlayerView:(PlayerView *)playerView
{
    playerView.delegate = nil;
    [playerView removeFromSuperview];
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([_delegate respondsToSelector:@selector(didDismiss)]){
        [_delegate didDismiss];
    }
}

@end
