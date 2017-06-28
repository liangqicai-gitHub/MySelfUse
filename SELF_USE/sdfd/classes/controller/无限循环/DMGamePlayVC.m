//
//  DMGamePlayVC.m
//  DM2
//
//  Created by 梁齐才 on 17/5/31.
//  Copyright © 2017年 LeiXiao CQ. All rights reserved.
//

#import "DMGamePlayVC.h"
#import "DMGPlayerView.h"

@interface DMGamePlayVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;//375时，34
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;//375时 240

@property (nonatomic,strong) DMGPlayerView *bottomView;

@end

@implementation DMGamePlayVC

#pragma mark - life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVars];
    [self initViews];
}

- (void)initVars
{
    CGFloat height = 69.0f;
    CGFloat y = [self deviceHeight] - height;
    CGFloat width = [self deviceWidth];
    _bottomView = [[DMGPlayerView alloc] initWithFrame:(CGRect){0,y,width,height}];
}

- (void)initViews
{
    CGFloat nowH = [self deviceHeight];
    CGFloat top = 34.0f * nowH / 375.0f;
    _top.constant = top;
    
    CGFloat imageH = 240.0f * nowH / 375.0f;
    _imageH.constant = imageH;
    
    [self.view addSubview:_bottomView];
    _bottomView.backgroundColor = [UIColor redColor];
    _bottomView.players = @[@{},
                            @{},
                            @{},
                            @{}
                            ];
}



- (CGFloat)deviceHeight
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize size = bounds.size;
    return MIN(size.height, size.width);
}

- (CGFloat)deviceWidth
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize size = bounds.size;
    return MAX(size.height, size.width);
}


#pragma mark - Orientation
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - action
- (IBAction)exit:(UIButton *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
