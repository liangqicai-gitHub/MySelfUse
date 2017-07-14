//
//  UserDB+TableXiaomiStep.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/14.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "UserDB+TableXiaomiStep.h"

@implementation UserDB (TableXiaomiStep)



- (NSString *)tableXiaomiStep_creatTableSql
{
    NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"t_xiaomiStep" ofType:@"sql"];
    NSString *sql = [[NSString alloc]
                     initWithContentsOfFile:sqlPath
                     encoding:NSUTF8StringEncoding
                     error:nil];
    return sql;
}

@end
