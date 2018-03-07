//
//  UIGestureRecognizer+YRJGestureRecognizer.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "UIGestureRecognizer+YRJGestureRecognizer.h"

#import <objc/runtime.h>

static const int block_key;


@interface YRJUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation YRJUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (YRJGestureRecognizer)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self yrj_addActionBlock:block];
    return self;
}

- (void)yrj_addActionBlock:(void (^)(id sender))block {
    YRJUIGestureRecognizerBlockTarget *target = [[YRJUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _yrj_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)yrj_removeAllActionBlocks{
    NSMutableArray *targets = [self _yrj_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_yrj_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
