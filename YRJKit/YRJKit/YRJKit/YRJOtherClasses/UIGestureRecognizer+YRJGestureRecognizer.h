//
//  UIGestureRecognizer+YRJGestureRecognizer.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (YRJGestureRecognizer)

/**
 Initializes an allocated gesture-recognizer object with a action block.
 
 @param block  An action block that to handle the gesture recognized by the
 receiver. nil is invalid. It is retained by the gesture.
 
 @return An initialized instance of a concrete UIGestureRecognizer subclass or
 nil if an error occurred in the attempt to initialize the object.
 */
- (instancetype)initWithActionBlock:(void (^)(id sender))block;

/**
 Adds an action block to a gesture-recognizer object. It is retained by the
 gesture.
 
 @param block A block invoked by the action message. nil is not a valid value.
 */
- (void)yrj_addActionBlock:(void (^)(id sender))block;

/**
 Remove all action blocks.
 */
- (void)yrj_removeAllActionBlocks;

@end
