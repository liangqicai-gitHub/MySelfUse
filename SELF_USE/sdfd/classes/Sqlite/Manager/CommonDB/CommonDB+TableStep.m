//
//  CommonDB+TableStep.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/13.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "CommonDB+TableStep.h"
#import "SqliteDBStore+insert.h"
#import "SqliteDBStore+select.h"
#import "SqliteDBStore+delete.h"
#import "NSDate+RDLogic.h"
#define KTableStepTableName @"step"
#define KTableStepColumnPK @"date"
#define KTableStepColumnStep @"step"

#define KTableStep_PKValue(v) (NSInteger)(v.timeIntervalSince1970 * 1000.0)


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


- (NSArray <NSDictionary *>*)tableStep_allRecords
{
    return [super selectInTable:KTableStepTableName];
}


- (BOOL)tableStep_deleteOldData
{
    NSDate *date = [NSDate date].startDate;
    date = [NSDate dateWithTimeInterval:-3600 * 240 sinceDate:date];
    NSInteger ts = KTableStep_PKValue(date);
    
    NSString *sql = Str_F(@"delete from %@ where %@ < %zd",
                          KTableStepTableName,
                          KTableStepColumnPK,
                          ts
                          );
    
    return [super deletWithSql:sql];
}



- (BOOL)tableStep_insertRecordWithDate:(NSDate *)date
                                 steps:(NSInteger)step
{
    
    NSDictionary *vd = @{KTableStepColumnPK : @(KTableStep_PKValue(date)),
                         KTableStepColumnStep : @(step)
                         };
    return [super insertOrReplace:KTableStepTableName value:vd];
}

/*查询步数*/
- (NSInteger)tableStep_queryStepsSinceDate:(NSDate *)sd
                                    toDate:(NSDate *)ed
{
    NSInteger start = KTableStep_PKValue(sd);
    NSInteger end = KTableStep_PKValue(ed);
    
    NSString *sql = Str_F(@"select sum(%@) as totalStep from %@ where %@ >= %zd and %@ <= %zd",
                          KTableStepColumnStep,
                          KTableStepTableName,
                          KTableStepColumnPK,
                          start,
                          KTableStepColumnPK,
                          end);
    
    NSDictionary *rs = [[super selectWithSql:sql] safeObjAtIndex:0];
    if (rs){
        id steps = rs[@"totalStep"];
        if ([steps isKindOfClass:[NSNumber class]]){
            return [steps integerValue];
        }
    }
    
    return 0;
}




@end
