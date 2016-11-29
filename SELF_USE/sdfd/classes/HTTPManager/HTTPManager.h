//
//  HTTPManager.h
//  sdfd
//
//  Created by 梁齐才 on 16/11/28.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,HTTPManagerRequestSerializerType)
{
    HTTPManagerRequestSerializerType_HTTPDefault,
    HTTPManagerRequestSerializerType_JSON,
    HTTPManagerRequestSerializerType_PropertyList
};

typedef NS_ENUM(NSInteger,HTTPManagerResponseSerializerType)
{
    HTTPManagerResonSerializerType_Data,
    HTTPManagerResonSerializerType_JSON
};



@interface HTTPManager : AFHTTPSessionManager

/*
 如果不传 completionQueue 就在 mainqueue里面
 */
- (instancetype)initWithRequestSerializerType:(HTTPManagerRequestSerializerType)requestSerializerType
                       responseSerializerType:(HTTPManagerResponseSerializerType)responseSerializerType;


- (instancetype)initWithCompletionQueue:(dispatch_queue_t)completionQueue
                  requestSerializerType:(HTTPManagerRequestSerializerType)requestSerializerType
                 responseSerializerType:(HTTPManagerResponseSerializerType)responseSerializerType;


#pragma mark - get

- (NSInteger)GET:(NSString *)URLString
      parameters:(id)parameters
   comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock;


- (NSInteger)GET:(NSString *)URLString
      parameters:(id)parameters
    downProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
   comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock;


#pragma mark - post

- (NSInteger)POST:(NSString *)URLString
       parameters:(id)parameters
    comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock;


- (NSInteger)POST:(NSString *)URLString
       parameters:(id)parameters
     downProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
    comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock;


- (NSInteger)          POST:(NSString *)URLString
                  parameters:(id)parameters
   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
              uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
               comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock;




// cancel
- (void)cancelTaskByTaskIdentifier:(NSInteger)taskIdentifier;

- (void)cancelAllTask;

@end


