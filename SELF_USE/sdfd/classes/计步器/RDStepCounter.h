//
//  RDStepCounter.h
//  sdfd
//
//  Created by 梁齐才 on 17/5/18.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "StepCounter.h"

@interface RDStepCounter : StepCounter

//因为这个是需要持续计步，所以请使用单例
+ (instancetype)sharedStepCounter;


@end
