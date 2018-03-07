//
//  NSDate+YRJDate.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSDate+YRJDate.h"

@implementation NSDate (YRJDate)

#pragma mark - 时间戳处理/计算日期
+ (NSString *)yrj_compareCureentTimeWithDate:(NSTimeInterval)timeStamp {
    
    NSDate *yrj_timeDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSTimeInterval yrj_timeInterval = [yrj_timeDate timeIntervalSinceNow];
    
    yrj_timeInterval = -yrj_timeInterval;
    
    NSInteger temp = 0;
    
    NSCalendar *yrj_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger yrj_unitFlags  = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *yrj_dateComponents = [yrj_calendar components:yrj_unitFlags
                                                         fromDate:yrj_timeDate];
    
    if (yrj_timeInterval < 60) {
        
        return [NSString stringWithFormat:@"刚刚"];
        
    } else if((temp = yrj_timeInterval / 60) < 60){
        
        return [NSString stringWithFormat:@"%ld分钟前", (long)temp];
        
    } else if((temp = yrj_timeInterval / 3600) < 24){
        
        return [NSString stringWithFormat:@"%ld小时前", (long)temp];
        
    } else if ((temp = yrj_timeInterval / 3600 / 24) == 1) {
        
        return [NSString stringWithFormat:@"昨天%ld时", (long)yrj_dateComponents.hour];
        
    } else if ((temp = yrj_timeInterval / 3600 / 24) == 2) {
        
        return [NSString stringWithFormat:@"前天%ld时", (long)yrj_dateComponents.hour];
        
    } else if((temp = yrj_timeInterval / 3600 / 24) < 31){
        
        return [NSString stringWithFormat:@"%ld天前", (long)temp];
        
    } else if((temp = yrj_timeInterval / 3600 / 24 / 30) < 12){
        
        return [NSString stringWithFormat:@"%ld个月前",(long)temp];
        
    } else {
        
        return [NSString stringWithFormat:@"%ld年前", (long)temp / 12];
    }
}

+ (NSString *)yrj_getCurrentTimeStamp {
    
    NSDate *yrj_cureentDate = [NSDate date];
    
    return [NSString stringWithFormat:@"%ld", (long)[yrj_cureentDate timeIntervalSince1970]];
}

+ (NSString *)yrj_displayTimeWithTimeStamp:(NSTimeInterval)timeStamp {
    
    NSDate *yrj_timeDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSCalendar *yrj_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger yrj_unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *yrj_dateComponents = [yrj_calendar components:yrj_unitFlags
                                                         fromDate:yrj_timeDate];
    
    NSInteger yrj_year   = yrj_dateComponents.year;
    NSInteger yrj_month  = yrj_dateComponents.month;
    NSInteger yrj_day    = yrj_dateComponents.day;
    NSInteger yrj_hour   = yrj_dateComponents.hour;
    NSInteger yrj_minute = yrj_dateComponents.minute;
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日 %ld:%ld", (long)yrj_year, (long)yrj_month, (long)yrj_day, (long)yrj_hour, (long)yrj_minute];
}

+ (NSString *)yrj_displayTimeWithTimeStamp:(NSTimeInterval)timeStamp
                                formatter:(NSString *)formatter {
    
    if ([NSString stringWithFormat:@"%@", @(timeStamp)].length == 13) {
        
        timeStamp /= 1000.0f;
    }
    
    NSDate *yrj_timeDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSDateFormatter *yrj_dateFormatter = [[NSDateFormatter alloc] init];
    
    yrj_dateFormatter.dateFormat = formatter;
    
    return [yrj_dateFormatter stringFromDate:yrj_timeDate];
}

+ (NSString *)yrj_getDateStringWithDate:(NSDate *)date
                             formatter:(NSString *)formatter {
    
    NSDateFormatter *yrj_dateFormatter = [[NSDateFormatter alloc] init];
    
    yrj_dateFormatter.dateFormat = formatter;
    
    return [yrj_dateFormatter stringFromDate:date];
}

+ (NSString *)yrj_calculateDaysWithDate:(NSDate *)date {
    
    NSDate *yrj_currentDate = [NSDate date];
    
    NSCalendar *yrj_calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateComponents *comps_today = [yrj_calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                   fromDate:yrj_currentDate];
    NSDateComponents *comps_other = [yrj_calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                   fromDate:date];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        
        return @"今天";
        
    } else if (comps_today.year == comps_other.year &&
               comps_today.month == comps_other.month &&
               (comps_today.day - comps_other.day) == -1 ) {
        
        return @"明天";
        
    } else if (comps_today.year == comps_other.year &&
               comps_today.month == comps_other.month &&
               (comps_today.day - comps_other.day) == -2) {
        
        return @"后天";
    }
    
    return @"";
}

#pragma mark - 获取日期
+ (NSUInteger)yrj_getEraWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitEra
                                                                       date:date];
    
    return yrj_dateComponents.era;
}

+ (NSUInteger)yrj_getYearWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitYear
                                                                       date:date];
    
    return yrj_dateComponents.year;
}

+ (NSUInteger)yrj_getMonthWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitMonth
                                                                       date:date];
    
    return yrj_dateComponents.month;
}

+ (NSUInteger)yrj_getDayWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitDay
                                                                       date:date];
    
    return yrj_dateComponents.day;
}

+ (NSUInteger)yrj_getHourWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitHour
                                                                       date:date];
    
    return yrj_dateComponents.hour;
}

+ (NSUInteger)yrj_getMinuteWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitMinute
                                                                       date:date];
    
    return yrj_dateComponents.minute;
}

+ (NSUInteger)yrj_getSecondWithDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitSecond
                                                                       date:date];
    
    return yrj_dateComponents.second;
}

+ (NSInteger)yrj_getWeekdayStringFromDate:(NSDate *)date {
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:NSCalendarUnitWeekday
                                                                       date:date];
    
    return yrj_dateComponents.weekday;
}

+ (NSInteger)yrj_getDateTimeDifferenceWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate {
    
    NSCalendar *yrj_calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *yrj_dateComponents = [yrj_calendar components:NSCalendarUnitDay
                                                         fromDate:beginDate
                                                           toDate:endDate
                                                          options:0];
    
    return yrj_dateComponents.day;
}

+ (NSDate *)yrj_getMonthFirstDeteWithDate:(NSDate *)date {
    
    return [self yrj_getDaysDateWithDate:date
                                   days:-[self yrj_getDayWithDate:date] + 1];
}

+ (NSDate *)yrj_getMonthLastDayWithDate:(NSDate *)date {
    
    NSDate *yrj_firstDate = [self yrj_getMonthFirstDeteWithDate:date];
    NSDate *yrj_monthDate = [self yrj_getMonthDateWithDate:yrj_firstDate
                                                  months:1];
    return [self yrj_getDaysDateWithDate:yrj_monthDate
                                   days:-1];
}

+ (NSUInteger)yrj_getWeekOfYearWithDate:(NSDate *)date {
    
    NSUInteger yrj_week = 1;
    NSUInteger yrj_year = [self yrj_getYearWithDate:date];
    
    NSDate *yrj_lastDate = [self yrj_getMonthLastDayWithDate:date];
    
    while ([self yrj_getYearWithDate:[self yrj_getDaysDateWithDate:yrj_lastDate
                                                            days:-7 * yrj_week]] == yrj_year) {
        yrj_week++;
    };
    
    return yrj_week;
}

+ (NSDate *)yrj_getTomorrowDay:(NSDate *)date {
    
    NSCalendar *yrj_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *yrj_dateComponents = [yrj_calendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                         fromDate:date];
    
    yrj_dateComponents.day = yrj_dateComponents.day + 1;
    
    return [yrj_calendar dateFromComponents:yrj_dateComponents];
}

+ (NSDate *)yrj_getYearDateWithDate:(NSDate *)date years:(NSInteger)years {
    
    NSCalendar *yrj_calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateComponents *yrj_dateComponents = [[NSDateComponents alloc] init];
    
    yrj_dateComponents.year = years;
    
    return [yrj_calendar dateByAddingComponents:yrj_dateComponents
                                        toDate:date
                                       options:0];
}

+ (NSDate *)yrj_getMonthDateWithDate:(NSDate *)date
                             months:(NSInteger)months {
    
    
    NSDateComponents *yrj_dateComponents = [[NSDateComponents alloc] init];
    
    yrj_dateComponents.month = months;
    
    return [self yrj_getDateWithDateComponents:yrj_dateComponents
                                         date:date];
}

+ (NSDate *)yrj_getDaysDateWithDate:(NSDate *)date days:(NSInteger)days {
    
    NSDateComponents *yrj_dateComponents = [[NSDateComponents alloc] init];
    
    yrj_dateComponents.day = days;
    
    return [self yrj_getDateWithDateComponents:yrj_dateComponents
                                         date:date];
}

+ (NSDate *)yrj_getHoursDateWithDate:(NSDate *)date hours:(NSInteger)hours {
    
    NSDateComponents *yrj_dateComponents = [[NSDateComponents alloc] init];
    
    yrj_dateComponents.hour = hours;
    
    return [self yrj_getDateWithDateComponents:yrj_dateComponents
                                         date:date];
}

+ (NSDate *)yrj_getDateWithDateComponents:(NSDateComponents *)dateComponents date:(NSDate *)date {
    
    NSCalendar *yrj_calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    return [yrj_calendar dateByAddingComponents:dateComponents
                                        toDate:date
                                       options:0];
}

#pragma mark - 日期判断
+ (BOOL)yrj_isLeapYear:(NSDate *)date {
    
    NSUInteger yrj_year = [self yrj_getYearWithDate:date];
    
    return ((yrj_year % 4 == 0) && (yrj_year % 100 != 0)) || (yrj_year % 400 == 0);
}

+ (BOOL)yrj_checkTodayWithDate:(NSDate *)date {
    
    NSInteger yrj_calendarUnit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *yrj_dateComponents = [self yrj_getCalendarWithUnitFlags:yrj_calendarUnit
                                                                       date:date];
    
    NSDateComponents *yrj_currentDateComponents = [self yrj_getCalendarWithUnitFlags:yrj_calendarUnit
                                                                              date:[NSDate date]];
    
    return (yrj_currentDateComponents.year == yrj_dateComponents.year) &&
    (yrj_currentDateComponents.month == yrj_dateComponents.month) &&
    (yrj_currentDateComponents.day == yrj_dateComponents.day);
}


#pragma mark - 获取NSDateComponents
+ (NSDateComponents *)yrj_getCalendarWithUnitFlags:(NSCalendarUnit)unitFlags date:(NSDate *)date {
    
    NSCalendar *yrj_calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    return [yrj_calendar components:unitFlags
                          fromDate:date];
}

@end
