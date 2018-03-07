//
//  NSMutableArray+YRJMutableArray.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSMutableArray+YRJMutableArray.h"

@implementation NSMutableArray (YRJMutableArray)

- (void)yrj_addSafeObject:(id)object {
    
    if (object == nil) {
        
        return;
    } else {
        
        [self addObject:object];
    }
}

- (void)yrj_insertSafeObject:(id)object
                      index:(NSUInteger)index {
    
    if (object == nil) {
        
        return;
        
    } else if (index > self.count) {
        
        [self insertObject:object
                   atIndex:self.count];
        
    } else {
        
        [self insertObject:object
                   atIndex:index];
    }
}

- (void)yrj_insertSafeArray:(NSArray *)array
                  indexSet:(NSIndexSet *)indexSet {
    
    if (indexSet == nil) {
        
        return;
    } else if (indexSet.count != array.count || indexSet.firstIndex > array.count) {
        
        [self insertObject:array
                   atIndex:self.count];
        
    } else {
        
        [self insertObjects:array
                  atIndexes:indexSet];
    }
}

- (void)yrj_safeRemoveObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        
        return;
    } else {
        
        [self removeObjectAtIndex:index];
    }
}

- (void)yrj_safeRemoveObjectsInRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length   = range.length;
    
    if (location + length > self.count) {
        
        return;
    } else {
        
        [self removeObjectsInRange:range];
    }
}

@end
