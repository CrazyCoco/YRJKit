/*******************************************************************************
 # File        : YRJTools.m
 # Project     : YRJKit
 # Author      : YURENJIE
 # Created     : 2018/3/7
 # Corporation : yurenjie
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "YRJTools.h"

@implementation YRJTools

+ (NSString *)getDateWithStamp:(NSString *)stamp format:(NSString *)format{
    
    if (format == nil || [format isEqualToString:@""]) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[stamp integerValue]];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:format];
    
    //返回指定格式时间字符串
    
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

+ (NSString *)getStampWithDateString:(NSString *)datestring  format:(NSString *)format{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate * date = [formatter dateFromString:datestring];
    
    NSNumber * stamp = [NSNumber numberWithDouble:[date timeIntervalSince1970]];
    
    return stamp.stringValue;
    
}

+ (NSString *)getNowStamp{
    
    NSDate * date = [NSDate date];
    
    NSNumber * stamp = [NSNumber numberWithDouble:[date timeIntervalSince1970]];
    
    return stamp.stringValue;
    
}

+ (NSString *)getNowDateStringWithFormat:(NSString *)format{
    
    return [self getDateWithStamp:[self getNowStamp] format:format];
}

+ (NSString *)timeBeforeOrAfterInfoWithStamp:(NSString *)stamp{
    
    //获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - [stamp integerValue]; //时间差
    
    NSString * str;
    NSString * str1;
    
    if (timeInt > 0) {
        str = @"以前";
        str1 = @"刚刚";
    }else{
        str = @"之后";
        str1 = @"现在";
        timeInt = -timeInt;
    }
    
    
    
    int year = timeInt / (3600 * 24 * 30 *12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;
    int second = timeInt;
    if (year > 0) {
        return [NSString stringWithFormat:@"%d年%@",year,str];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%d个月%@",month,str];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%d天%@",day,str];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时%@",hour,str];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分钟%@",minute,str];
    }else{
        return [NSString stringWithFormat:@"%@", str1];
    }
}


/**
 摩羯座 12月22日------1月19日
 水瓶座 1月20日-------2月18日
 双鱼座 2月19日-------3月20日
 白羊座 3月21日-------4月19日
 金牛座 4月20日-------5月20日
 双子座 5月21日-------6月21日
 巨蟹座 6月22日-------7月22日
 狮子座 7月23日-------8月22日
 处女座 8月23日-------9月22日
 天秤座 9月23日------10月23日
 天蝎座 10月24日-----11月21日
 射手座 11月22日-----12月21日
 */
+ (NSString *)getConstellationInfo:(NSString *)date {
    
    date = [self getDateWithStamp:date format:@"YYYY-MM-DD"];
    
    //计算月份
    NSString * retStr = @"";
    NSString * birthStr = [date substringFromIndex:5];
    int month = 0;
    NSString * theMonth = [birthStr substringToIndex:2];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        month = [[theMonth substringFromIndex:1] intValue];
    }else{
        month = [theMonth intValue];
    }
    
    //计算天数
    int day=0;
    NSString * theDay = [birthStr substringFromIndex:3];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        day = [[theDay substringFromIndex:1] intValue];
    }else {
        day = [theDay intValue];
    }
    
    if (month < 1 || month > 12 || day < 1 || day > 31){
        return @"错误日期格式!";
    }
    if(month == 2 && day > 29) {
        return @"错误日期格式!!";
    }else if(month == 4 || month == 6 || month == 9 || month == 11) {
        if (day > 30) {
            return @"错误日期格式!!!";
        }
    }
    
    NSString * astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString * astroFormat = @"102123444543";
    
    retStr = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month * 2 - (day < [[astroFormat substringWithRange:NSMakeRange((month - 1), 1)] intValue] - (-19)) * 2,2)]];
    
    return [NSString stringWithFormat:@"%@座",retStr];
}


+ (NSString *)getAgeWithBirthday:(NSString *)birthday{
    
    NSString *dateStr = [self getDateWithStamp:birthday format:@"yyyy/MM/dd"];
    
    NSString *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [dateStr substringWithRange:NSMakeRange(dateStr.length-2, 2)];
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSDateComponents *compomemts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    NSInteger nowYear = compomemts.year;
    NSInteger nowMonth = compomemts.month;
    NSInteger nowDay = compomemts.day;
    
    // 计算年龄
    NSInteger userAge = nowYear - year.intValue - 1;
    if ((nowMonth > month.intValue) || (nowMonth == month.intValue && nowDay >= day.intValue)) {
        userAge++;
    }
    
    return [NSString stringWithFormat:@"%ld",(long)userAge];
    
}


@end
