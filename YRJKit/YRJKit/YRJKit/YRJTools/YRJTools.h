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

@end
