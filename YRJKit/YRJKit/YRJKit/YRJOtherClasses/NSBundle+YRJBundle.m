//
//  NSBundle+YRJBundle.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSBundle+YRJBundle.h"

@implementation NSBundle (YRJBundle)

+ (NSString *)yrj_getBundleDisplayName {
    
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)yrj_getBundleShortVersionString {
    
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)yrj_getBundleVersion {
    
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)yrj_getBundleIdentifier {
    
    return [[self mainBundle] bundleIdentifier];
}

+ (NSString *)yrj_getBundleFileWithName:(NSString *)name
                                  type:(NSString *)type {
    
    return [[self mainBundle] pathForResource:name
                                       ofType:type];
}

@end
