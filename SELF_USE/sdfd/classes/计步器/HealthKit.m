//
//  HealthKit.m
//  sdfd
//
//  Created by 梁齐才 on 17/7/12.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "HealthKit.h"
#import <HealthKit/HealthKit.h>

@interface HealthKit ()

@property(nonatomic,strong) HKHealthStore *healthStore;


@end

@implementation HealthKit


- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
    }
    return self;
}


- (void)initVars
{
    //查看healthKit在设备上是否可用，iPad上不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        LQCDLog(@"   buzhidchi  ");
        return ;
    }
    
    //创建healthStore对象
    self.healthStore = [[HKHealthStore alloc]init];
    
    //设置需要获取的权限 这里仅设置了步数
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            //获取步数后我们调用获取步数的方法
//            [self readStepCount];
            [self readStepQ];
        }
        else
        {
            LQCDLog(@"   quanxian shabi  ");
        }
    }];
    
    
    
    
    
    
}


- (void)readStepQ
{
    HKSampleType *sampleType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    HKSourceQuery *query =
    [[HKSourceQuery alloc]
     initWithSampleType:sampleType
     samplePredicate:nil
     completionHandler:^(HKSourceQuery *query, NSSet *sources, NSError *error) {
         
         if (error) {
             NSLog(@"*** An error occured while gathering the sources for step date.%@ ***", error.localizedDescription);
             abort();
         }
         
         for (HKSource *source in sources) {
             
             LQCDLog(@"dsfasdfdsaf %@   %@",source.name,source.bundleIdentifier);
             
         }
         
         [self readStepCount];
     }];
    
    [self.healthStore executeQuery:query];
}


- (void)readStepCount
{
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptor来告诉healthStore怎么样将结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    //时间结果与想象中不同是因为它显示的是0区
    NSLog(@"今天%@",nowDay);
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
    NSLog(@"明天%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    
    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了*/
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
        int allStepCount = 0;
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            
            NSInteger step = (NSInteger)[quantity doubleValueForUnit:[HKUnit countUnit]];
            LQCDLog(@"%zd  result.source.name =  %@   %@",step,result.source.name,result.source.bundleIdentifier);
            
            
            
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
//            NSLog(@"%d",stepNum);
            //把一天中所有时间段中的步数加到一起
            allStepCount = allStepCount + stepNum;
        }
        
        //查询要放在多线程中进行，如果要对UI进行刷新，要回到主线程
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            LQCDLog(@"dsfadsfadfa");
        }];
    }];
    //执行查询
    [self.healthStore executeQuery:sampleQuery];
}


@end
