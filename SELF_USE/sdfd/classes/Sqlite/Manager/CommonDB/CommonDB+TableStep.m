//
//  CommonDB+TableStep.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/13.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "CommonDB+TableStep.h"
#define KTableStepTableName @"step"
#define KTableStepColumnPK @"date"
#define KTableStepColumnHourPerfix @"hour"

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


- (BOOL)insertOneDay:(RDOneDayStepM *)oneDaySetp
{
    NSDictionary *d = [self convertRDOneDayStepM:oneDaySetp];
    if (!d) return NO;
    
    return [self insertTable:KTableStepTableName
                    valueDic:d];
}


- (BOOL)updateOneDay:(RDOneDayStepM *)oneDaySetp
{
    NSDictionary *vd = [self convertRDOneDayStepM:oneDaySetp];
    if (!vd) return NO;
    
    NSDictionary *cd = @{KTableStepColumnPK:@((NSInteger)oneDaySetp.date.timeIntervalSince1970)};
    return [self updateTable:KTableStepTableName
                       value:vd
                   condition:cd];
}


- (NSDictionary *)convertRDOneDayStepM:(RDOneDayStepM *)m
{
    if (![m isKindOfClass:[RDOneDayStepM class]]) return nil;
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:@((NSInteger)m.date.timeIntervalSince1970) forKey:KTableStepColumnPK];
    
    if (![NSArray isEmpty:m.hourSteps]){
        for (RDHourStepM *one in m.hourSteps) {
            NSInteger hour = one.hour;
            if (hour < 0 || hour >23) continue;
            NSString *columnName = Str_F(@"%@%zd",KTableStepColumnHourPerfix,hour);
            [d setObject:@(one.steps) forKey:columnName];
        }
    }
    
    return d;
}


@end
