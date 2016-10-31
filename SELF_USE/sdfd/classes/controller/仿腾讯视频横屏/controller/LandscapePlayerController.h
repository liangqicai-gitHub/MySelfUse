//
//  LandscapePlayerController.h
//  sdfd
//
//  Created by 梁齐才 on 16/10/29.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerView;
@class LandscapePlayerController;
@protocol LandscapePlayerControllerDelegate <NSObject>

- (void)didDismiss;

@end

@interface LandscapePlayerController : UIViewController

@property (nonatomic,weak) PlayerView *playerView;

@property (nonatomic,weak) id <LandscapePlayerControllerDelegate>delegate;

@end
