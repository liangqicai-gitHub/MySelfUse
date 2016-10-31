//
//  PortraitPlayerView.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/29.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "PortraitPlayerController.h"
#import "PlayerView.h"
#import "LandscapePlayerController.h"

@interface PortraitPlayerController ()
<
PlayerViewDelegate,
LandscapePlayerControllerDelegate
>

@property (nonatomic,strong) PlayerView *playerView;

@end

@implementation PortraitPlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [_playerView playVideo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)initViews
{
    _playerView = [[PlayerView alloc] initWithFileName:@"test.mp4"];
    _playerView.delegate = self;
    _playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_playerView];
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
}


#pragma mark - PlayerViewDelegate

- (void)didClickedPlayerView:(PlayerView *)playerView
{
    _playerView.delegate = nil;
    LandscapePlayerController *vc = [[LandscapePlayerController alloc] init];
    vc.delegate = self;
    vc.playerView = _playerView;
    [_playerView removeFromSuperview];
    [self.tabBarController presentViewController:vc animated:NO completion:nil];
}

#pragma mark - LandscapePlayerControllerDelegate

- (void)didDismiss
{
    [self.view addSubview:_playerView];
    _playerView.delegate = self;
    [_playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
    _playerView.transform = transform;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            _playerView.transform = CGAffineTransformIdentity;
        }];
    });
}


@end
