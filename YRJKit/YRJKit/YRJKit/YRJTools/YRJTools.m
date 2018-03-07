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
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

@end
