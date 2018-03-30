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

#import <MapKit/MapKit.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>

#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>


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

+ (void)after:(NSTimeInterval)time block:(GCDBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

+ (GCDTask)delay:(NSTimeInterval)time task:(GCDBlock)block {
    __block dispatch_block_t closure = block;
    __block GCDTask result;
    GCDTask delayedClosure = ^(BOOL cancel){
        if (closure) {
            if (!cancel) {
                dispatch_async(dispatch_get_main_queue(), closure);
            }
        }
        closure = nil;
        result = nil;
    };
    result = delayedClosure;
    [self after:time block:^{
        if (result)
            result(NO);
    }];
    
    return result;
}


+ (void)cancel:(GCDTask)task {
    task(YES);
}

+ (void)noMobilePhoneSleep{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

+ (void)setRootControllerWithController:(UIViewController *)controller options:(UIViewAnimationOptions)options{
    // options是动画选项
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:1.0f options:options animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = controller;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)gotoAppPermissionsSetting{
    
    if (UIApplicationOpenSettingsURLString != NULL) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{}
               completionHandler:nil];
        } else {
            [application openURL:URL];
        }
    }
    
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIWindow *)getWindow {
    UIWindow* win = nil; //[UIApplication sharedApplication].keyWindow;
    for (id item in [UIApplication sharedApplication].windows) {
        if ([item class] == [UIWindow class]) {
            if (!((UIWindow*)item).hidden) {
                win = item;
                break;
            }
        }
    }
    return win;
}

+ (CGFloat)getCacheSize{
    
    //获取自定义缓存大小
    //用枚举器遍历 一个文件夹的内容
    //1.获取 文件夹枚举器
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    __block NSUInteger count = 0;
    //2.遍历
    for (NSString *fileName in enumerator) {
        NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;//自定义所有缓存大小
    }
    // 得到是字节  转化为M
    CGFloat totalSize = ((CGFloat)count)/1024/1024;
    return totalSize;
    
}

+ (void)cleanCache{
    
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
    
}


+ (BOOL)isHaveLocationPermissions{
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"没有定位权限");
        return NO;
    }
    
    return YES;
}


+ (BOOL)isHaveCameraPermissions{
    
    AVAuthorizationStatus statusVideo = [AVCaptureDevice  authorizationStatusForMediaType:AVMediaTypeVideo];
    if (statusVideo == AVAuthorizationStatusDenied) {
        NSLog(@"没有摄像头权限");
        return NO;
    }

    return YES;
}

+ (BOOL)isHaveMicrophonePermissions{

    //是否有麦克风权限
    AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (statusAudio == AVAuthorizationStatusDenied) {
        NSLog(@"没有录音权限");
        return NO;
    }

    return YES;
}

+ (BOOL)isHavePhotoalbumPermissions{

    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
    
}


//通过图片Data数据第一个字节 来获取图片扩展名
+ (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c)
    {
        case 0xFF:
            return @"jpeg";
            
        case 0x89:
            return @"png";
            
        case 0x47:
            return @"gif";
            
        case 0x49:
        case 0x4D:
            return @"tiff";
            
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"]
                && [testString hasSuffix:@"WEBP"])
            {
                return @"webp";
            }
            
            return nil;
    }
    
    return nil;
}

+ (NSString *)getMacAddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (UIImage *)getFirstImageWithVideoUrl:(NSURL *)url{
    
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generate1.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
    
    return one;
    
}


+ (NSInteger)getVideoTimeByUrlString:(NSURL *)urlString {
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:urlString];
    CMTime time = [avUrl duration];
    int seconds = ceil(time.value/time.timescale);
    return seconds;
}

+ (void)phoneVibrates{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}



@end
