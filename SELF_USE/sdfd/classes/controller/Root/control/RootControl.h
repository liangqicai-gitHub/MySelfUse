//
//  RootControl.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootControl : UIViewController

/**
 *  考虑到，很多时候，切换用户登录，操作很麻烦。
 *  我们干脆直接替换 rootViewController。
 *  所以这个不是一个单例，其实你可能每次登陆后，重新设置rootViewControl
 *  @return
 */
+ (RootControl *)rootControl;


@property (nonatomic,assign) NSInteger selectedIndex;



@end

