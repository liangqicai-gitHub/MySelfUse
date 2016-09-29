//
//  UIScrollView+Refresh.h
//  sdfd
//
//  Created by 梁齐才 on 16/6/12.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (Refresh)


-(void)addRefreshHeader:(MJRefreshComponentRefreshingBlock)block;

-(void)headerEndRefresh;

-(void)headerBeginRefresh;


- (void)addRefreshFooter:(MJRefreshComponentRefreshingBlock)block;

- (void)footerEndRefresh;

- (void)footerBeginRefresh;

@end



@interface LQCDIYRefreshHeader : MJRefreshHeader


@end



@interface LQCDIYRefreshFooter : MJRefreshBackFooter


@end