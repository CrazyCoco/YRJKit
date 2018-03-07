//
//  NSMutableArray+YRJMutableArray.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (YRJMutableArray)

/**
 安全的添加一个对象
 
 @param object 对象
 */
- (void)yrj_addSafeObject:(id)object;

/**
 根据索引安全的插入一个对象
 
 @param object 对象
 @param index NSUInteger
 */
- (void)yrj_insertSafeObject:(id)object
                      index:(NSUInteger)index;

/**
 根据索引安全的插入一个数组
 
 @param array NSArray
 @param indexSet NSIndexSet
 */
- (void)yrj_insertSafeArray:(NSArray *)array
                  indexSet:(NSIndexSet *)indexSet;

/**
 根据索引安全的删除一个对象
 
 @param index NSUInteger
 */
- (void)yrj_safeRemoveObjectAtIndex:(NSUInteger)index;

/**
 根据范围安全的删除
 
 @param range NSRange
 */
- (void)yrj_safeRemoveObjectsInRange:(NSRange)range;

@end
