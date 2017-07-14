//
//  CommonDB+TableStep.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/13.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "CommonDB+TableStep.h"

@implementation CommonDB (TableStep)


- (NSString *)tableStep_creatTableStepSql
{
    NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"t_step" ofType:@"sql"];
    NSString *sql = [[NSString alloc]
                     initWithContentsOfFile:sqlPath
                     encoding:NSUTF8StringEncoding
                     error:nil];
    return sql;
}


@end
