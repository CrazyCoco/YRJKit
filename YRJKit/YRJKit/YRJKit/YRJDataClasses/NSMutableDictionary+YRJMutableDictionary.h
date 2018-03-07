//
//  NSMutableDictionary+YRJMutableDictionary.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (YRJMutableDictionary)

/**
 安全的存储一个键值对
 
 @param object 值
 @param key 键
 */
- (void)yrj_setSafeObject:(id)object
                  forKey:(id)key;

/**
 安全的根据一个键获取对应的对象
 
 @param key key
 @return id
 */
- (id)yrj_safeObjectForKey:(id)key;

/**
 安全的根据value获取对应的key
 
 @param value id object
 @return id
 */
- (id)yrj_safeKeyForValue:(id)value;

@end
