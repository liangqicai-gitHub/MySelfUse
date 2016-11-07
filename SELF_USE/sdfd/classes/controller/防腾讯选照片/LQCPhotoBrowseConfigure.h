//
//  LQCPhotoBrowseConfigure.h
//  sdfd
//
//  Created by 梁齐才 on 16/11/5.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LQCPhotoBrowseFetchImageDelegate <NSObject>

@required
- (void)LQCPB_asynFetchImageWithPath:(NSURL *)imagePath
                            progress:(void (^)(NSInteger, NSInteger))progressBlock
                            complete:(void (^)(UIImage *, NSError *, NSURL *))completeBlock;

- (UIImage *)LQCPB_fetchImage:(NSURL *)imagePath;

@end


@interface LQCPhotoBrowseConfigure : NSObject

@property (nonatomic,strong) UIImage *loadingImage;
@property (nonatomic,strong) UIImage *loadFailImage;
@property (nonatomic,weak) id <LQCPhotoBrowseFetchImageDelegate> fetchImageDelegate;

@end
