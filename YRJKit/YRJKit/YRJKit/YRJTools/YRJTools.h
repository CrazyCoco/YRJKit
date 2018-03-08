/*******************************************************************************
 # File        : YRJTools.h
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

#import <Foundation/Foundation.h>

@interface YRJTools : NSObject

/**
 根据时间戳返回指定格式时间

 @param stamp 时间戳
 @param format 时间格式 默认是yyyy-MM-dd HH:mm:ss
 @return 指定格式的时间
 */
+ (NSString *)getDateWithStamp:(NSString *)stamp format:(NSString *)format;

/**
 根据时间和时间格式返回时间戳

 @param datestring 时间
 @param format 时间格式
 @return 时间戳
 */
+ (NSString *)getStampWithDateString:(NSString *)datestring  format:(NSString *)format;

/**
 获取当前时间的时间戳

 @return 时间戳
 */
+ (NSString *)getNowStamp;

/**
获取指定格式的当前时间字符串

 @param format 格式
 @return 时间
 */
+ (NSString *)getNowDateStringWithFormat:(NSString *)format;


/**
 根据时间戳计算: 几分钟之前，几小时之前...或之后

 @param stamp 时间戳
 @return 返回字符串
 */
+ (NSString *)timeBeforeOrAfterInfoWithStamp:(NSString *)stamp;


/**
 根据生日获取星座

 @param date 生日时间戳
 @return 星座
 */
+ (NSString *)getConstellationInfo:(NSString *)date;


/**
 根据生日计算年龄

 @param birthday 生日时间戳
 @return 年龄
 */
+ (NSString *)getAgeWithBirthday:(NSString *)birthday;



@end
