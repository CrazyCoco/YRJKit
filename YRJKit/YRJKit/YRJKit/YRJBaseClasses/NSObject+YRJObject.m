//
//  NSObject+YRJObject.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSObject+YRJObject.h"

@implementation NSObject (YRJObject)

#pragma mark - Runtime
+ (void)yrj_exchangeImplementationsWithClass:(Class)class
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    Method yrj_originalMethod = class_getInstanceMethod(class, originalSelector);
    Method yrj_swizzledSelector = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL yrj_didAddMethod = [self yrj_addMethodWithClass:class
                                      originalSelector:originalSelector
                                      swizzledSelector:swizzledSelector];
    
    if (yrj_didAddMethod) {
        
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(yrj_originalMethod),
                            method_getTypeEncoding(yrj_originalMethod));
    } else {
        
        method_exchangeImplementations(yrj_originalMethod, yrj_swizzledSelector);
    }
}

+ (BOOL)yrj_addMethodWithClass:(Class)class
             originalSelector:(SEL)originalSelector
             swizzledSelector:(SEL)swizzledSelector {
    
    Method yrj_swizzledSelector = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL yrj_didAddMethod = class_addMethod(class,
                                           originalSelector,
                                           class_getMethodImplementation(class, swizzledSelector),
                                           method_getTypeEncoding(yrj_swizzledSelector));
    
    
    return yrj_didAddMethod;
}

+ (void)yrj_replaceMethodWithClass:(Class)class
                 originalSelector:(SEL)originalSelector
                 swizzledSelector:(SEL)swizzledSelector {
    
    Method yrj_originalMethod = class_getInstanceMethod(class, originalSelector);
    
    class_replaceMethod(class,
                        swizzledSelector,
                        method_getImplementation(yrj_originalMethod),
                        method_getTypeEncoding(yrj_originalMethod));
}

+ (NSArray <NSString *> *)yrj_getClassList {
    
    NSMutableArray *yrj_classArray = [NSMutableArray array];
    
    unsigned int yrj_classCount;
    
    Class *yrj_class = objc_copyClassList(&yrj_classCount);
    
    for (int i = 0; i < yrj_classCount; i++) {
        
        [yrj_classArray addObject:NSStringFromClass(yrj_class[i])];
    }
    
    free(yrj_class);
    
    [yrj_classArray sortedArrayUsingSelector:@selector(compare:)];
    
    return yrj_classArray;
}

+ (NSArray <NSString *> *)yrj_getClassMethodListWithClass:(Class)class {
    
    NSMutableArray *yrj_selectorArray = [NSMutableArray array];
    
    unsigned int yrj_methodCount = 0;
    
    const char *yrj_className = class_getName(class);
    
    Class yrj_metaClass = objc_getMetaClass(yrj_className);
    
    Method *yrj_methodList = class_copyMethodList(yrj_metaClass, &yrj_methodCount);
    
    for (int i = 0; i < yrj_methodCount; i++) {
        
        Method yrj_method = yrj_methodList[i];
        
        SEL yrj_selector = method_getName(yrj_method);
        
        const char *yrj_constCharMethodName = sel_getName(yrj_selector);
        
        NSString *yrj_methodName = [[NSString alloc] initWithUTF8String:yrj_constCharMethodName];
        
        [yrj_selectorArray addObject:yrj_methodName];
    }
    
    free(yrj_methodList);
    
    return yrj_selectorArray;
}

+ (NSArray <NSString *> *)yrj_getPropertyListWithClass:(Class)class {
    
    unsigned int yrj_propertyCount;
    
    objc_property_t *yrj_propertyList = class_copyPropertyList(class, &yrj_propertyCount);
    
    NSMutableArray *yrj_propertyArray = [NSMutableArray array];
    
    for (int i = 0; i < yrj_propertyCount; i++) {
        
        objc_property_t yrj_property = yrj_propertyList[i];
        
        const char *yrj_constCharProperty = property_getName(yrj_property);
        
        NSString *yrj_propertyName = [NSString stringWithCString:yrj_constCharProperty
                                                       encoding:NSUTF8StringEncoding];
        
        [yrj_propertyArray addObject:yrj_propertyName];
    }
    
    free(yrj_propertyList);
    
    return yrj_propertyArray;
}

+ (NSArray <NSString *> *)yrj_getIVarListWithClass:(Class)class {
    
    unsigned int yrj_ivarCount;
    
    Ivar *yrj_ivarList = class_copyIvarList(class, &yrj_ivarCount);
    
    NSMutableArray *yrj_ivarArray = [NSMutableArray array];
    
    for (int i = 0; i < yrj_ivarCount; i++) {
        
        Ivar yrj_ivar = yrj_ivarList[i];
        
        const char *yrj_constCharIvar = ivar_getName(yrj_ivar);
        
        NSString *yrj_ivarName = [NSString stringWithCString:yrj_constCharIvar
                                                   encoding:NSUTF8StringEncoding];
        
        [yrj_ivarArray addObject:yrj_ivarName];
    }
    
    free(yrj_ivarList);
    
    return yrj_ivarArray;
}

+ (NSArray <NSString *> *)yrj_getProtocolListWithClass:(Class)class {
    
    unsigned int yrj_protocolCount;
    
    NSMutableArray *yrj_protocolArray = [NSMutableArray array];
    
    __unsafe_unretained Protocol **yrj_protocolList = class_copyProtocolList(class, &yrj_protocolCount);
    
    for (int i = 0; i < yrj_protocolCount; i++) {
        
        Protocol *yrj_protocal = yrj_protocolList[i];
        
        const char *yrj_constCharProtocolName = protocol_getName(yrj_protocal);
        
        NSString *yrj_protocolName = [NSString stringWithCString:yrj_constCharProtocolName
                                                       encoding:NSUTF8StringEncoding];
        
        [yrj_protocolArray addObject:yrj_protocolName];
    }
    
    free(yrj_protocolList);
    
    return yrj_protocolArray;
}

- (BOOL)yrj_hasPropertyWithKey:(NSString *)key {
    
    objc_property_t yrj_property = class_getProperty([self class], [key UTF8String]);
    
    return (BOOL)yrj_property;
}

- (BOOL)yrj_hasIvarWithKey:(NSString *)key {
    
    Ivar yrj_ivar = class_getInstanceVariable([self class], [key UTF8String]);
    
    return (BOOL)yrj_ivar;
}

#pragma mark - GCD
- (void)yrj_performAsyncWithComplete:(YRJObject)complete {
    
    dispatch_queue_t yrj_globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(yrj_globalQueue, complete);
}

- (void)yrj_performMainThreadWithComplete:(YRJObject)complete
                                  isWait:(BOOL)isWait {
    
    if (isWait) {
        
        dispatch_sync(dispatch_get_main_queue(), complete);
    } else {
        
        dispatch_async(dispatch_get_main_queue(), complete);
    }
}

- (void)yrj_performWithAfterSecond:(NSTimeInterval)afterSecond
                         complete:(YRJObject)complete {
    
    dispatch_time_t yrj_time = dispatch_time(DISPATCH_TIME_NOW, afterSecond * NSEC_PER_SEC);
    
    dispatch_after(yrj_time, dispatch_get_main_queue(), complete);
}

@end
