//
//  NSURL+YRJUrl.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSURL+YRJUrl.h"
#import "NSString+YRJString.h"

@implementation NSURL (YRJUrl)

+ (void)yrj_openBrowserWithURL:(NSString *)urlString {
    
    [[UIApplication sharedApplication] openURL:[self URLWithString:urlString]];
}

#pragma mark - Document
+ (NSURL *)yrj_getDocumentFileURL {
    
    return [self yrj_getFileURLForDirectory:NSDocumentDirectory];
}

+ (NSString *)yrj_getDocumentPathURL {
    
    return [self yrj_getPathURLForDirectory:NSDocumentDirectory];
}

#pragma mark - Library
+ (NSURL *)yrj_getLibraryFileURL {
    
    return [self yrj_getFileURLForDirectory:NSLibraryDirectory];
}

+ (NSString *)yrj_getLibraryPathURL {
    
    return [self yrj_getPathURLForDirectory:NSLibraryDirectory];
}

#pragma mark - Caches
+ (NSURL *)yrj_getCachesFileURL {
    
    return [self yrj_getFileURLForDirectory:NSCachesDirectory];
}

+ (NSString *)yrj_getCachesPathURL {
    
    return [self yrj_getPathURLForDirectory:NSCachesDirectory];
}

#pragma mark - 获取File URL
+ (NSURL *)yrj_getFileURLForDirectory:(NSSearchPathDirectory)directory {
    
    NSArray *yrj_urlArray = [NSFileManager.defaultManager URLsForDirectory:directory
                                                                inDomains:NSUserDomainMask];
    
    return yrj_urlArray.lastObject;
}

#pragma mark - 获取Path URL
+ (NSString *)yrj_getPathURLForDirectory:(NSSearchPathDirectory)directory {
    
    NSArray *yrj_urlArray = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    
    return [NSString stringWithFormat:@"%@", yrj_urlArray.firstObject];
}

@end
