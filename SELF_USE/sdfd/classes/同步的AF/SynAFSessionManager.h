//
//  SynAFSessionManager.h
//  sdfd
//
//  Created by 梁齐才 on 16/6/4.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 In the case where you need to performs a synchronous load of the specified URL request. 
 
 I wirte this base on AFNetworking (version 3.1.0) 
 
 */


@interface SynAFSessionManager : NSObject

+ (id)synGET:(NSString *)URLString parameters:(id)parameters;




@end
