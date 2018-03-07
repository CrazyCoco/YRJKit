//
//  NSObject+YRJObject.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void(^YRJObject)(void);

@interface NSObject (YRJObject)

#pragma mark - Runtime
/**
 交换两个实例方法
 
 @param class Clss类
 @param originalSelector 被交换方法
 @param swizzledSelector 交换方法
 */
+ (void)yrj_exchangeImplementationsWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 给指定类添加额外的方法
 
 @param class Clss类
 @param originalSelector 被拦截方法
 @param swizzledSelector 拦截方法
 */
+ (BOOL)yrj_addMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 拦截并且替换原来的方法
 
 @param class Clss类
 @param originalSelector 被拦截方法
 @param swizzledSelector 拦截方法
 */
+ (void)yrj_replaceMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 获取所有已注册的类
 
 @return NSArray
 */
+ (NSArray <NSString *> *)yrj_getClassList;

/**
 获取指定类的Mehtod List
 
 @param class Class
 @return NSArray
 */
+ (NSArray <NSString *> *)yrj_getClassMethodListWithClass:(Class)class;

/**
 获取指定类的Property List
 
 @param class Class
 @return NSArray
 */
+ (NSArray <NSString *> *)yrj_getPropertyListWithClass:(Class)class;

/**
 获取指定类的Ivar List
 
 @param class Class
 @return NSArray
 */
+ (NSArray <NSString *> *)yrj_getIVarListWithClass:(Class)class;

/**
 获取指定类的Protocol List
 
 @param class Class
 @return NSArray
 */
+ (NSArray <NSString *> *)yrj_getProtocolListWithClass:(Class)class;

/**
 根据Key判断是否包含该属性
 
 @param key NSString
 @return BOOL
 */
- (BOOL)yrj_hasPropertyWithKey:(NSString *)key;

/**
 根据Key判断是否包含该成员变量
 
 @param key NSString
 @return BOOL
 */
- (BOOL)yrj_hasIvarWithKey:(NSString *)key;

#pragma mark - GCD
/**
 异步执行Block
 
 @param complete CLObject
 */
- (void)yrj_performAsyncWithComplete:(YRJObject)complete;

/**
 在主线程中执行GCD, 是否需要等待
 
 @param complete CLObject
 @param isWait BOOL
 */
- (void)yrj_performMainThreadWithComplete:(YRJObject)complete isWait:(BOOL)isWait;

/**
 指点延迟几秒后执行
 
 @param afterSecond NSTimeInterval
 @param complete CLObject
 */
- (void)yrj_performWithAfterSecond:(NSTimeInterval)afterSecond complete:(YRJObject)complete;




@end
