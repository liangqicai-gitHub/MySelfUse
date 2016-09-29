//
//  GCDTest.h
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  我需要实现这个需求。
 *  用N个线程去下载N张图片，然后放到一个数组中。（我并没有真的去下载哈）
 */




@interface GCDTest : NSObject



// dispatch_group_t 练习
+ (void)multipleThreadShareArr:(NSArray *)dataArr complete:(void (^)(NSArray *rs))completeBlock;


//lock练习
+ (void)testLockIfNeedLock:(BOOL)needLock;




@end






