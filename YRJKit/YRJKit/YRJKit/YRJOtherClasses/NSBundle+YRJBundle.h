//
//  NSBundle+YRJBundle.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (YRJBundle)

/**
 获取App名称
 
 @return NSString
 */
+ (NSString *)yrj_getBundleDisplayName;

/**
 获取App版本号
 
 @return NSString
 */
+ (NSString *)yrj_getBundleShortVersionString;

/**
 获取Build版本号
 
 @return NSString
 */
+ (NSString *)yrj_getBundleVersion;

/**
 获取App Bundle Identifier
 
 @return NSString
 */
+ (NSString *)yrj_getBundleIdentifier;

/**
 获取指定名字的Bundle
 
 @param name NSString
 @param type NSString
 @return NSString
 */
+ (NSString *)yrj_getBundleFileWithName:(NSString *)name
                                  type:(NSString *)type;

@end
