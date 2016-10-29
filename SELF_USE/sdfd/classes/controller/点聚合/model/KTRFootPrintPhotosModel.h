//
//  KTRFootPrintPhotosModel.h
//  kartor3
//
//  Created by 梁齐才 on 16/10/25.
//  Copyright © 2016年 CST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTRFootPrintPhotosModel : NSObject

//真实环境时，请放到M文件中
@property(nonatomic,strong) NSNumber *log;
@property(nonatomic,strong) NSNumber *lat;
@property(nonatomic,strong) NSArray *imageUrls;

@property(readonly) CLLocationCoordinate2D coordinate;




@end
