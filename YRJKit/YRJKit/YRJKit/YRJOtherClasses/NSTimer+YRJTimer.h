//
//  NSTimer+YRJTimer.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YRJTimer)(void);

@interface NSTimer (YRJTimer)

/**
 创建一个NSTimer对象, 并添加进当前线程
 
 @param timeInterval NSTimeInterval
 @param repeats BOOL
 @param complete CLTimer
 @return NSTimer
 */
+ (NSTimer *)yrj_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats complete:(YRJTimer)complete;

/**
 创建一个NSTimer对象
 
 @param timeInterval NSTimeInterval
 @param repeats BOOL
 @param complete CLTimer
 @return NSTimer
 */
+ (NSTimer *)yrj_timerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats complete:(YRJTimer)complete;

/**
 开始NSTimer
 */
- (void)yrj_resumeTimer;

/**
 暂停NSTimer
 */
- (void)yrj_pauseTimer;

/**
 延迟指定的时间执行NSTimer
 
 @param timeInterval NSTimeInterval
 */
- (void)yrj_resumeTimerAfterTimeInterval:(NSTimeInterval)timeInterval;

@end
