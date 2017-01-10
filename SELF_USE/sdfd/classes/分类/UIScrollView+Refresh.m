//
//  UIScrollView+Refresh.m
//  sdfd
//
//  Created by 梁齐才 on 16/6/12.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "LQCFreshView.h"
#import "MJRefresh.h"

@implementation UIScrollView (Refresh)

- (void)addRefreshHeader:(MJRefreshComponentRefreshingBlock)block
{
    [self setMj_header:[LQCDIYRefreshHeader headerWithRefreshingBlock:block]];
}

- (void)headerEndRefresh
{
    if (self.mj_header){
        [self.mj_header endRefreshing];
    }
}



- (void)addRefreshFooter:(MJRefreshComponentRefreshingBlock)block
{
    [self setMj_footer:[LQCDIYRefreshFooter footerWithRefreshingBlock:block]];
}

- (void)footerEndRefresh
{
    if (self.mj_footer){
        [self.mj_footer endRefreshing];
    }
}


@end



@interface LQCDIYRefreshHeader ()

@property (nonatomic,weak) UIView *content;
@property (nonatomic,weak) LQCFreshView *realHeader;

@end

@implementation LQCDIYRefreshHeader


- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (!_content){
        UIView *content = [[UIView alloc] initWithFrame:self.bounds];
        content.backgroundColor = [UIColor redColor];
        [self addSubview:content];
     
        LQCFreshView *header = [LQCFreshView instanceWithType:FreshType_Header];
        [content addSubview:header];
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(content);
        }];
        
        _content = content;
        _realHeader = header;
    }
    
    [_content setFrame:self.bounds];
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (!_content) return;
    
    if (state == MJRefreshStatePulling){
        [_realHeader setPullingState];
    }else if (state == MJRefreshStateRefreshing){
        [_realHeader setFreshingState];
    }else if(state == MJRefreshStateIdle){
        [_realHeader setNormalState];
    }
}


@end


@interface LQCDIYRefreshFooter ()

@property (nonatomic,weak) UIView *content;
@property (nonatomic,weak) LQCFreshView *realFooter;

@end

@implementation LQCDIYRefreshFooter


- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (!_content){
        UIView *content = [[UIView alloc] initWithFrame:self.bounds];
        content.backgroundColor = [UIColor redColor];
        [self addSubview:content];
        
        LQCFreshView *footer = [LQCFreshView instanceWithType:FreshType_Footer];
        [content addSubview:footer];
        [footer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(content);
        }];
        
        _content = content;
        _realFooter = footer;
    }
    
    [_content setFrame:self.bounds];
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (!_content) return;
    
    if (state == MJRefreshStatePulling){
        [_realFooter setPullingState];
    }else if (state == MJRefreshStateRefreshing){
        [_realFooter setFreshingState];
    }else if(state == MJRefreshStateIdle){
        [_realFooter setNormalState];
    }
}


@end
