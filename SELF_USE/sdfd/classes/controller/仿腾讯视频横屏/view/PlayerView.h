//
//  PlayerView.h
//  sdfd
//
//  Created by 梁齐才 on 16/10/29.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerView;
@protocol PlayerViewDelegate <NSObject>

- (void)didClickedPlayerView:(PlayerView *)playerView;

@end

@interface PlayerView : UIView

- (instancetype)initWithFileName:(NSString *)fileName;

@property (nonatomic,weak) id <PlayerViewDelegate> delegate;

- (void)playVideo;

@end
