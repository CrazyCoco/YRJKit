//
//  YRJDefine.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//



#define YRJ_WEAK_SELF(type)  __weak __typeof(&*self)weakSelf = self
#define YRJ_STRONG_SELF(type)  __strong __typeof(&*self)weakSelf = self

#define YRJ_GET_METHOD_RETURN_OBJC(objc) if (objc) return objc


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
