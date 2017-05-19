//
//  SynAFSessionManager.m
//  sdfd
//
//  Created by 梁齐才 on 16/6/4.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "SynAFSessionManager.h"
#import "AFNetworking.h"

@implementation SynAFSessionManager


+ (id)synGET:(NSString *)URLString parameters:(id)parameters
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    __block id data = nil;
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        data = responseObject;
        NSLog(@"in block");
        dispatch_semaphore_signal(sema);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        data = error;
        NSLog(@"in block");
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"out the block ");
    return data;
}




@end
