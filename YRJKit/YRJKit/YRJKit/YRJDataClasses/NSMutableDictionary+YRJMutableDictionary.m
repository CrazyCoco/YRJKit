//
//  NSMutableDictionary+YRJMutableDictionary.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSMutableDictionary+YRJMutableDictionary.h"

@implementation NSMutableDictionary (YRJMutableDictionary)

- (void)yrj_setSafeObject:(id)object
                  forKey:(id)key {
    
    if ([key isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    if ([object isKindOfClass:[NSNull class]]) {
        
        [self setValue:@""
                forKey:key];
        
    } else {
        [self setValue:object
                forKey:key];
    }
}

- (id)yrj_safeObjectForKey:(id)key {
    
    if (key != nil) {
        
        return [self objectForKey:key];
        
    } else {
        
        return nil;
    }
}

- (id)yrj_safeKeyForValue:(id)value {
    
    for (id key in self.allKeys) {
        
        if ([value isEqual:[self objectForKey:key]]) {
            
            return key;
        }
    }
    return nil;
}

@end
