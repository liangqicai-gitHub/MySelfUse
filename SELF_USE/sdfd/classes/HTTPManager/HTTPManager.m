//
//  HTTPManager.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/28.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "HTTPManager.h"

@interface HTTPManager ()



@end



@implementation HTTPManager


#pragma mark - init

+ (instancetype)manager
{
    dispatch_queue_t completionQueue = dispatch_queue_create("HTTPManager_completionQueue", DISPATCH_QUEUE_CONCURRENT);
    
    return [[HTTPManager alloc] initWithCompletionQueue:completionQueue
                                  requestSerializerType:HTTPManagerRequestSerializerType_HTTPDefault
                                 responseSerializerType:HTTPManagerResonSerializerType_JSON];
}


- (instancetype)initWithRequestSerializerType:(HTTPManagerRequestSerializerType)requestSerializerType
                       responseSerializerType:(HTTPManagerResponseSerializerType)responseSerializerType
{
    return [self initWithCompletionQueue:nil
                   requestSerializerType:requestSerializerType
                  responseSerializerType:responseSerializerType];
}

- (instancetype)initWithCompletionQueue:(dispatch_queue_t)completionQueue
                  requestSerializerType:(HTTPManagerRequestSerializerType)requestSerializerType
                 responseSerializerType:(HTTPManagerResponseSerializerType)responseSerializerType
{
    self = [super init];
    if(self){
        if (completionQueue){
            self.completionQueue = completionQueue;
        }
        
        self.requestSerializer = [self getRequestSerializerByType:requestSerializerType];
        self.responseSerializer = [self getResponseSerializerByType:responseSerializerType];
    }
    return self;
}


- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)
getRequestSerializerByType:(HTTPManagerRequestSerializerType)requestSerializerType
{
    switch (requestSerializerType) {
        case HTTPManagerRequestSerializerType_HTTPDefault:
            return [AFHTTPRequestSerializer serializer];
            break;
        case HTTPManagerRequestSerializerType_JSON:
            return [AFJSONRequestSerializer serializer];
            break;
        case HTTPManagerRequestSerializerType_PropertyList:
            return [AFPropertyListRequestSerializer serializer];
            break;
        default:
            return [AFHTTPRequestSerializer serializer];
            break;
    }
}


- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)
getResponseSerializerByType:(HTTPManagerResponseSerializerType)responseSerializerType
{
    switch (responseSerializerType) {
        case HTTPManagerResonSerializerType_Data:
            return [AFHTTPResponseSerializer serializer];
            break;
        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

#pragma mark - get


- (NSInteger)GET:(NSString *)URLString
      parameters:(id)parameters
   comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                        URLString:URLString
                                                       parameters:parameters
                                                   uploadProgress:nil
                                                 downloadProgress:nil
                                                    comlpectBlock:comlpectBlock];
    
    if (dataTask){
        [dataTask resume];
        return dataTask.taskIdentifier;
    }else{
        return NSNotFound;
    }
}



- (NSInteger)GET:(NSString *)URLString
      parameters:(id)parameters
    downProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
   comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                        URLString:URLString
                                                       parameters:parameters
                                                   uploadProgress:nil
                                                 downloadProgress:downloadProgress
                                                    comlpectBlock:comlpectBlock];
    
    if (dataTask){
        [dataTask resume];
        return dataTask.taskIdentifier;
    }else{
        return NSNotFound;
    }
}


#pragma mark - post

- (NSInteger)POST:(NSString *)URLString
       parameters:(id)parameters
    comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST"
                                                        URLString:URLString
                                                       parameters:parameters
                                                   uploadProgress:nil
                                                 downloadProgress:nil
                                                    comlpectBlock:comlpectBlock];
    
    if (dataTask){
        [dataTask resume];
        return dataTask.taskIdentifier;
    }else{
        return NSNotFound;
    }
}


- (NSInteger)POST:(NSString *)URLString
       parameters:(id)parameters
     downProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
    comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST"
                                                        URLString:URLString
                                                       parameters:parameters
                                                   uploadProgress:nil
                                                 downloadProgress:downloadProgress
                                                    comlpectBlock:comlpectBlock];
    
    if (dataTask){
        [dataTask resume];
        return dataTask.taskIdentifier;
    }else{
        return NSNotFound;
    }
}



- (NSInteger)          POST:(NSString *)URLString
                 parameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
             uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
              comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (comlpectBlock){
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                comlpectBlock(nil, nil,serializationError);
            });
        }
        
        return NSNotFound;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (comlpectBlock){
            comlpectBlock(task,responseObject,error);
        }
    }];
    
    [task resume];
    
    return task.taskIdentifier;
}


#pragma mark - 

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                downloadProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
                                   comlpectBlock:(void (^)(NSURLSessionDataTask *task,id responseObject,NSError *error))comlpectBlock

{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (comlpectBlock){
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                comlpectBlock(nil, nil,serializationError);
            });
        }
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (comlpectBlock){
                               comlpectBlock(dataTask,responseObject,error);
                           }
                       }];
    
    return dataTask;
}


#pragma mark - cancel

- (void)cancelTaskByTaskIdentifier:(NSInteger)taskIdentifier
{
    if (taskIdentifier == NSNotFound) return;
    
    for (NSURLSessionTask *task in self.tasks) {
        if (taskIdentifier != task.taskIdentifier) continue;
        [task cancel];
        break;
    }
}

- (void)cancelAllTask
{
    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
}


@end
