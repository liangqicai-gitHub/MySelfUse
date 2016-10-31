//
//  PlayerView.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/29.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "PlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerView ()

@property (nonatomic ,readwrite) AVPlayerItem *item;

@property (nonatomic ,readwrite) AVPlayerLayer *playerLayer;

@property (nonatomic ,readwrite) AVPlayer *player;

@property (nonatomic,strong) CALayer *dLayer;

@end

@implementation PlayerView


- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self){
        [self setUpPlayerWithFileName:fileName];
    }
    return self;
}


- (void)setUpPlayerWithFileName:(NSString *)fileName;
{
    NSString *path = [NSString mainBundelResourcePath:fileName];
    NSURL *url = [NSURL fileURLWithPath:path];
    _item = [[AVPlayerItem alloc] initWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:_item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:_playerLayer];
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"切换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
    }];

}


- (void)btnClick:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(didClickedPlayerView:)]){
        [_delegate didClickedPlayerView:self];
    }
}



- (void)playVideo
{
    [_player play];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_playerLayer setFrame:self.layer.bounds];
}

@end
