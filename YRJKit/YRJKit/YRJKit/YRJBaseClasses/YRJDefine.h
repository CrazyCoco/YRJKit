//
//  YRJDefine.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//


//弱引用和强引用
#define WEAK_SELF(type)  __weak __typeof(&*self)weakSelf = self
#define STRONG_SELF(type)  __strong __typeof(&*self)weakSelf = self

// app名称
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

// app版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

//app build版本
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

//手机序列号
#define PHONE_IDENTIFIERNUMBER [[UIDevice currentDevice] uniqueIdentifier];

//手机别名： 用户定义的名称
#define PHONE_NAME [[UIDevice currentDevice] name];

//设备名称
#define PHONE_DEVICENAME [[UIDevice currentDevice] systemName];

//手机系统版本
#define PHONE_VERSION [[UIDevice currentDevice] systemVersion];

//手机型号
#define PHONE_MODEL [[UIDevice currentDevice] model];


//屏幕宽度
#define SCREEN_WIDTH \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

//屏幕高度
#define SCREEN_HEIGHT \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

//屏幕Size
#define SCREEN_SIZE \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

// View 圆角和加边框
#define VIEW_BORDER_RADIUS(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define VIEW_RADIUS(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//颜色
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define RANDOM_COLOR           KRGB_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define COLOR_WITH_HEX(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//UserDefaults
#define USERDEFAULT  [NSUserDefaults standardUserDefaults]

//删除NSUserDefaults所有记录
#define DELETEALLUSERDEFAULTS [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];

//NSNotificationCenter
#define NOTIFICATIONCENTER  [NSNotificationCenter defaultCenter]

//AppDelegate
#define APPDELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

//字符串是否为空
#define STRING_IS_EMPTY(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define ARRAY_IS_EMPTY(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define DICT_IS_EMPTY(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//是否是空对象
#define OBJECT_IS_EMPYT(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//由角度转换弧度
#define DEGREES_TO_RADIAN(x)      (M_PI * (x) / 180.0)

//由弧度转换角度
#define RANDIAN_TO_DEGREES(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define START_TIME CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define END_TIME   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒temp路径
#define TEMP_PATH NSTemporaryDirectory()

//获取沙盒Cache路径
#define CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//隐藏键盘
#define KEYBOARD_CANCLE [[[[UIApplication sharedApplication] delegate ]window]  endEditing:YES]

#define YRJ_GET_METHOD_RETURN_OBJC(objc) if (objc) return objc

//GCD代码只执行一次
#define DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//在主线程上运行
#define DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//开启异步线程
#define DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

//FORMAT
#define FORMAT(f, ...)      [NSString stringWithFormat:f, ## __VA_ARGS__]


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
