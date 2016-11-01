//
//  KTRFootprintBottomView.h
//  kartor3
//
//  Created by 梁齐才 on 16/11/1.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FootprintBottomViewZanStatus){
    FootprintBottomViewZanStatus_Already    = 0,//已经赞过
    FootprintBottomViewZanStatus_NotYet,        //还没有赞
};


@class KTRFootprintBottomView;
@protocol KTRFootprintBottomViewDelegate <NSObject>

//点击了评论按钮的回调
- (void)didClickedCommentButtonInFootprintBottomView:(KTRFootprintBottomView *)footprintBottomView;

//点击了赞的按钮
- (void)didClickedZanButtonInFootprintBottomView:(KTRFootprintBottomView *)footprintBottomView;

@end


@interface KTRFootprintBottomView : UIView

/*
快速的创建方法
 */
+ (KTRFootprintBottomView *)newInstance;

+ (KTRFootprintBottomView *)newInstanceWithDelegate:(id <KTRFootprintBottomViewDelegate>)delegate;

@property(nonatomic,weak) id <KTRFootprintBottomViewDelegate> delegate;

@property(nonatomic,assign) FootprintBottomViewZanStatus zanStatus;

@property(nonatomic,assign) NSInteger scanNumber;

@property(nonatomic,assign) NSInteger zanNumber;

@property(nonatomic,assign) NSInteger commentNumber;

- (void)setZanStatus:(FootprintBottomViewZanStatus)zanStatus animation:(BOOL)Animation;

/*
 1、UI标注的100px（50个点），请使用该高度,
 2、虽然告知你高度，但还是请使用autolayout布局
 3、仍然可以使用其他高度，但是推荐使用该高度
 */
+ (CGFloat)exceptedHeight;

@end
