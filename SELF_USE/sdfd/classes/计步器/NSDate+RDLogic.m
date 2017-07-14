//
//  NSDate+RDLogic.m
//  RiceDonate
//
//  Created by ozr on 16/5/18.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import "NSDate+RDLogic.h"
#import "YYKit.h"

@implementation NSDate (RDLogic)

+ (NSDate *)dateWithCurWeekday:(NSInteger)weekday
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitMonth | NSCalendarUnitYear| NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:[NSDate date]];
    NSDateFormatter *getformatter = [[NSDateFormatter alloc] init];
    [getformatter setDateFormat:@"yyyy-MM-dd "];
    NSString *dateString = [getformatter stringFromDate:[NSDate date]];
    NSDate *todayStartDate = [getformatter dateFromString:dateString];
    return [[NSDate alloc] initWithTimeInterval:(weekday - components.weekday)*60*60*24 sinceDate:todayStartDate];
}

+ (NSDate *)curSaturdayDate
{
    return [self dateWithCurWeekday:7];
}

+ (NSTimeInterval)curDueTime
{
    return [self curSaturdayDate].timeIntervalSince1970 + 60 * 60 * 24;
}

+ (BOOL)bDueForRiceChatWithDueTime:(NSTimeInterval)dueTime
{
     //检查今天是否大于过期日期且不是同一天
    if (dueTime < [NSDate date].timeIntervalSince1970) {
        return YES;
    }else
    {
        return NO;
    }
}

+ (NSDate *)startDateFromTodayUTCWithDayCount:(NSInteger)dayCount
{
    NSDateFormatter *getformatter = [[NSDateFormatter alloc] init];
    [getformatter setDateFormat:@"yyyy-MM-dd "];
    //东八区时间
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [getformatter setTimeZone:timeZone];
    NSString *dateString = [getformatter stringFromDate:[NSDate date]];
    NSDate *date = [[NSDate alloc] initWithTimeInterval:- dayCount * 60 * 60 * 24
                                              sinceDate:[getformatter dateFromString:dateString]];

    return date;
}

+ (NSDate *)startDateFromTodayWithDayCount:(NSInteger)dayCount
{
    NSDateFormatter *getformatter = [[NSDateFormatter alloc] init];
    [getformatter setDateFormat:@"yyyy-MM-dd "];
    NSString *dateString = [getformatter stringFromDate:[NSDate date]];
    NSDate *date = [[NSDate alloc] initWithTimeInterval:- dayCount * 60 * 60 * 24
                                              sinceDate:[getformatter dateFromString:dateString]];
    
    return date;
}

- (NSDate *)startDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDate *startDate = [calendar dateFromComponents:components];
    return startDate;
}


/*
 本周第一天凌晨
 */
- (NSDate *)weekStartDate
{
    NSDate *now = [NSDate date];
    NSInteger week = now.weekday - 1;
    NSDate *sunday = [NSDate dateWithTimeIntervalSinceNow:week * -24 * 3600];
    return sunday.startDate;
}

- (BOOL)earlyThanDate:(NSDate *)date
{
    NSTimeInterval selft = self.timeIntervalSince1970;
    NSTimeInterval compt = date.timeIntervalSince1970;
    return selft <= compt;
}



+ (NSString *)dynamicTimeStringWithTimeInterval:(NSTimeInterval)createTime
{
    NSInteger now = (NSInteger)time(0);
    NSInteger yestodaySeconds = (NSInteger)[NSDate startDateFromTodayWithDayCount:1].timeIntervalSince1970;
    NSInteger todaySeconds = (NSInteger)[NSDate startDateFromTodayWithDayCount:0].timeIntervalSince1970;
    //今天
    if (todaySeconds < createTime) {
        
        if (now - createTime < 60 * 30) {
            return @"刚刚";
        }
        if (now - createTime < 60 * 60) {
            NSInteger min = (now - createTime) / 60;
            return Str_F(@"%zd分钟前",min);
        }
        NSInteger h = (now - createTime) / 3600;
        return  Str_F(@"%zd小时前",h);
        
    }else if (yestodaySeconds < createTime){
        return @"昨天";
    }else{
        NSDate *ct = [NSDate dateWithTimeIntervalSince1970:createTime];
        NSInteger month = [ct month];
        NSInteger day = [ct day];
        NSString *ms = month < 10 ? Str_F(@"0%zd",month) : Str_F(@"%zd",month);
        NSString *ds = day < 10 ? Str_F(@"0%zd",day) : Str_F(@"%zd",day);
        return Str_F(@"%@-%@",ms,ds);
    }
}


@end
