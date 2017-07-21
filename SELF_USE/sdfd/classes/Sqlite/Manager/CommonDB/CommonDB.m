//
//  CommonDB.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "CommonDB.h"
#import "CommonDB+TableStep.h"

@implementation CommonDB


- (instancetype)initWithDBPath:(NSString *)DBPath
                    encryptKey:(NSString *)encryptKey
{
    self = [super initWithDBPath:DBPath encryptKey:encryptKey];
    if (self){
        [self tableStep_deleteOldData];
    }
    return self;
}


- (NSDictionary *)versionSqlDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    /*版本12800  创建计步表*/
    [dic setObject:[self tableStep_creatTableStepSql]
            forKey:@"12800"];
    
    return dic;
}












@end
