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

//- (BOOL)insertOneDay:(RDOneDayStepM *)oneDaySetp;
//
//- (BOOL)updateOneDay:(RDOneDayStepM *)oneDaySetp;

//- (RDOneDayStepM *)selected

@end
