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
<PlayerViewDelegate>

@property (nonatomic,strong) PlayerView *playerView;

@end

@implementation PortraitPlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    
    [_playerView playVideo];
}

- (void)initViews
{
    _playerView = [[PlayerView alloc] initWithFileName:@"test.mp4"];
    _playerView.delegate = self;
    _playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_playerView];
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
}


#pragma mark - PlayerViewDelegate

- (void)didClickedPlayerView:(PlayerView *)playerView
{
    LandscapePlayerController *vc = [[LandscapePlayerController alloc] init];
    vc.playerView = _playerView;
    [self.tabBarController presentViewController:vc animated:NO completion:^{
        [_playerView removeFromSuperview];
        _playerView.delegate = nil;
        [vc.view addSubview:_playerView];
        [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
    }];
}

@end
