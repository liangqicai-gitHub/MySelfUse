//
//  CommonDB+TableStep.h
//  sdfd
//
//  Created by 梁齐才 on 17/7/13.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "CommonDB.h"
#import "RDStepService.h"

@interface CommonDB (TableStep)

/*12800 第一次创建该表*/
- (NSString *)tableStep_creatTableStepSql;


/*只保留10天的记录，10天之前的删除.*/
- (BOOL)tableStep_deleteOldData;


/*添加记录*/
- (BOOL)tableStep_insertRecordWithDate:(NSDate *)date
                                 steps:(NSInteger)step;


/*查询步数*/
- (NSInteger)tableStep_queryStepsSinceDate:(NSDate *)sd
                                    toDate:(NSDate *)ed;

@end
