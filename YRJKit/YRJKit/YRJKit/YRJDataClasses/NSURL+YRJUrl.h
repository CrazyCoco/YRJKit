//
//  NSURL+YRJUrl.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSURL (YRJUrl)

/**
 通过传入的URL地址打开外部浏览器
 
 @param urlString URL地址
 */
+ (void)yrj_openBrowserWithURL:(NSString *)urlString;

#pragma mark - Document
/**
 获取Document File URL
 
 @return NSURL
 */
+ (NSURL *)yrj_getDocumentFileURL;

/**
 获取Document Path URL
 
 @return NSString
 */
+ (NSString *)yrj_getDocumentPathURL;

#pragma mark - Library
/**
 获取Library File URL
 
 @return NSURL
 */
+ (NSURL *)yrj_getLibraryFileURL;

/**
 获取Library Path URL
 
 @return NSString
 */
+ (NSString *)yrj_getLibraryPathURL;

#pragma mark - Caches
/**
 获取Caches File URL
 
 @return NSURL
 */
+ (NSURL *)yrj_getCachesFileURL;

/**
 获取Caches Path URL
 
 @return NSString
 */
+ (NSString *)yrj_getCachesPathURL;

#pragma mark - 获取路径
/**
 获取指定NSSearchPathDirectory的File URL
 
 @param directory NSSearchPathDirectory
 @return NSURL
 */
+ (NSURL *)yrj_getFileURLForDirectory:(NSSearchPathDirectory)directory;

/**
 获取指定NSSearchPathDirectory的Path URL
 
 @param directory NSSearchPathDirectory
 @return NSString
 */
+ (NSString *)yrj_getPathURLForDirectory:(NSSearchPathDirectory)directory;

@end
