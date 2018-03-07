
//
//  UIBarButtonItem+YRJBarButtonItem.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "UIBarButtonItem+YRJBarButtonItem.h"

#import <objc/runtime.h>
static const int block_key;

@interface YRJUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation YRJUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end

@implementation UIBarButtonItem (YRJBarButtonItem)

- (void)setActionBlock:(void (^)(id sender))block {
    YRJUIBarButtonItemBlockTarget *target = [[YRJUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    YRJUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}


@end
