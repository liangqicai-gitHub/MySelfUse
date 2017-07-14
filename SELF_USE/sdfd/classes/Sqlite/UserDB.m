//
//  UserDB.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "UserDB.h"
#import "UserDB+TableXiaomiStep.h"

@implementation UserDB


- (NSDictionary *)versionSqlDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    /*版本12800  创建小米手环同步记录*/
    [dic setObject:[self tableXiaomiStep_creatTableSql]
            forKey:@"12800"];
    
    return dic;
}





@end
