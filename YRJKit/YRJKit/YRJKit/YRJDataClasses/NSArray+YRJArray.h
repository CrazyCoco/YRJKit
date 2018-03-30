//
//  NSArray+YRJArray.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YRJArray)

/**
 创建一个安全的Array
 
 @param object 对象, 可以为nil
 @return NSArray
 */
+ (instancetype _Nullable )yrj_initSafeArrayWithObject:(id _Nullable )object;

/**
 从数组里获取一个id对象, 索引超出之后, 也不会崩掉
 
 @param index 对象索引
 @return id
 */
- (id _Nullable )yrj_safeObjectAtIndex:(NSUInteger)index;

/**
 根据Range返回对应的Array
 
 @param range range, 这里就算超出了索引也不会引起问题
 @return NSArray
 */
- (NSArray *_Nullable)yrj_safeArrayWithRange:(NSRange)range;

/**
 根据对象返回对应的索引
 
 @param object 对象
 @return NSUInteger
 */
- (NSUInteger)yrj_safeIndexOfObject:(id _Nullable )object;

/**
 根据给定的Plist文件名返回里面的数组
 
 @param name Plist文件名
 @return NSArray
 */
+ (NSArray *_Nullable)yrj_getArrayWithPlistName:(NSString *_Nullable)name;


/**
 从指定的属性列表数据创建并返回一个数组。
 
 @param plist 是一个属性列表数据，其根对象是一个数组。
 返回由二进制plist数据创建的新数组，如果出现错误，则返回nil。
 */
+ (nullable NSArray *)yrj_arrayWithPlistData:(NSData *_Nullable)plist;

/**
 从指定的属性列表xml字符串创建并返回一个数组。
 
 @param plist 是一个属性列表xml字符串，它的根对象是一个数组。
 返回一个从plist字符串创建的新数组，如果出现错误，则返回nil。
 */
+ (nullable NSArray *)yrj_arrayWithPlistString:(NSString *_Nullable)plist;

/**
 将数组序列化为二进制属性列表数据。
 
 返回一个二进制plist数据，如果出现错误，则返回nil。
 */
- (nullable NSData *)yrj_plistData;

/**
 将数组序列化为xml属性列表字符串。
 
 返回一个plist xml字符串，如果出现错误，则返回nil。
 */
- (nullable NSString *)yrj_plistString;

/**
 返回位于随机索引中的对象。
 
 用随机索引值将数组中的对象返回。
 如果数组为空，则返回nil。
 */
- (nullable id)yrj_randomObject;

/**
 返回位于索引处的对象，或在出界时返回nil。
 它类似于“objectAtIndex:”，但它从不抛出异常。
 
 @ param index 该对象位于索引处。
 */
- (nullable id)yrj_objectOrNilAtIndex:(NSUInteger)index;

/**
 将对象转换为json字符串。如果出现错误，则返回nil。
 NSString / NSNumber NSDictionary / NSArray
 */
- (nullable NSString *)yrj_jsonStringEncoded;
- (nullable NSString *)yrj_jsonPrettyStringEncoded;

/**
 将对象转换为json字符串格式。如果出现错误，则返回nil。
 */
/**
 数组里面是否有指定数据
 
 @return return value description
 */
- (BOOL)yrj_isHaveObjc:(id _Nullable )obj;

/**
 去除数组中重复的对象

 @return return value description
 */
- (NSArray *)yrj_removesDuplicate;

@end

NS_ASSUME_NONNULL_END
