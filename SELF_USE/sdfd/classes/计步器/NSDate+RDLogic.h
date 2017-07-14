//
//  NSDate+RDLogic.h
//  RiceDonate
//
//  Created by ozr on 16/5/18.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RDLogic)

/**
 *  获取这个星期几 日期
 *
 *  @param weekday 1是星期天 7是星期六
 *
 *  @return date
 */
+ (NSDate *)dateWithCurWeekday:(NSInteger)weekday;

/**
 *  获取这个星期六 日期
 *
 *  @return date
 */
+ (NSDate *)curSaturdayDate;

/**
 *  创建米聊聊联系人的过期时间为下周日
 *
 *  @return date
 */
+ (NSTimeInterval)curDueTime;

/**
 *  检查是否过期
 *
 *  @param dueTime time
 *
 *  @return b
 */
+ (BOOL)bDueForRiceChatWithDueTime:(NSTimeInterval)dueTime;

/**
 *  距离今天上海时间倒数的第几天(昨天的时候,dayCount=1, 今天凌晨,dayCount=0)
 *
 *  @param dayCount 倒数几天
 *
 *  @return 日期
 */
+ (NSDate *)startDateFromTodayUTCWithDayCount:(NSInteger)dayCount;

/**
 *  距离今天伦敦时间倒数的第几天(昨天的时候,dayCount=1, 今天凌晨,dayCount=0)
 *
 *  @param dayCount 倒数几天
 *
 *  @return 日期
 */
+ (NSDate *)startDateFromTodayWithDayCount:(NSInteger)dayCount;

/*
 某个日期的凌晨
 */
- (NSDate *)startDate;


/*
 本周第一天凌晨
 */
- (NSDate *)weekStartDate;


- (BOOL)earlyThanDate:(NSDate *)date;


+ (NSString *)dynamicTimeStringWithTimeInterval:(NSTimeInterval)createTime;

@end
