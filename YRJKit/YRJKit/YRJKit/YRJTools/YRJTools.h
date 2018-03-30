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

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    sum, //和
    avg, //平均值
    max, //最大值
    min, //最小值
} NumType;


//延时执行回调
typedef void(^GCDTask)(BOOL cancel);
typedef void(^GCDBlock)(void);

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

/**
 延时执行任务

 @param time 延时时间
 @param block 回调
 @return return value description
 */
+ (GCDTask)delay:(NSTimeInterval)time task:(GCDBlock)block;
+ (void)cancel:(GCDTask)task;


/**
 禁止手机睡眠
 */
+ (void)noMobilePhoneSleep;


/**
 动画切换window的根控制器

 @param controller 跟视图
 @param options 动画
 */
+ (void)setRootControllerWithController:(UIViewController *)controller options:(UIViewAnimationOptions)options;

/**
 跳转app权限设置
 */
+ (void)gotoAppPermissionsSetting;


/**
 颜色转图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取window

 @return return value description
 */
+ (UIWindow *)getWindow;


/**
 获取app缓存大小

 @return return value description
 */
+ (CGFloat)getCacheSize;

/**
 清除app缓存
 */
+ (void)cleanCache;


/**
 检测定位权限

 @return return value description
 */
+ (BOOL)isHaveLocationPermissions;

/**
 检测相机权限

 @return return value description
 */
+ (BOOL)isHaveCameraPermissions;

/**
 检测麦克风权限

 @return return value description
 */
+ (BOOL)isHaveMicrophonePermissions;

/**
 检测相册权限

 @return return value description
 */
+ (BOOL)isHavePhotoalbumPermissions;

/**
 通过图片Data数据第一个字节 来获取图片扩展名

 @param data data description
 @return return value description
 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

/**
 获取设备Mac地址

 @return return value description
 */
+ (NSString *)getMacAddress;

/**
 获取一个视频的第一帧图片

 @param url url description
 @return return value description
 */
+ (UIImage *)getFirstImageWithVideoUrl:(NSURL *)url;

/**
 获取视频的时长

 @param urlString urlString description
 @return return value description
 */
+ (NSInteger)getVideoTimeByUrlString:(NSURL *)urlString;

/**
 让手机震动一下
 */
+ (void)phoneVibrates;

/**
 生成二维码
 
 @param codeString 二维码客串
 @return 二维码图片
 */
+ (UIImage *)qrCodeWithString:(NSString *)codeString;

/**
 根据年和月返回当月天数

 @param year year description
 @param month month description
 @return return value description
 */
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month;

/**
 车牌校验
 
 @return 是/否
 */
- (BOOL)isCarLicenceNumWithString:(NSString *)str;


/**
 快速求和，最大值，最小值，平均值

 @param arr arr description
 @param type type description
 @return return value description
 */
- (CGFloat)getNumWithArr:(NSArray *)arr type:(NumType)type;




@end
