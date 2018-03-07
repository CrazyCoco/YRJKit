//
//  NSTimer+YRJTimer.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSTimer+YRJTimer.h"

@implementation NSTimer (YRJTimer)

+ (NSTimer *)yrj_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats complete:(YRJTimer)complete {
    
    return [self scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(yrj_timerBlock:) userInfo:complete repeats:repeats];
}

+ (NSTimer *)yrj_timerWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats complete:(YRJTimer)complete {
    
    return [self timerWithTimeInterval:timeInterval target:self selector:@selector(yrj_timerBlock:) userInfo:complete repeats:repeats];
}

+ (void)yrj_timerBlock:(NSTimer *)timer; {
    
    if([timer userInfo]) {
        
        void (^yrj_block)(void) = (void (^)(void))[timer userInfo];
        
        yrj_block();
    }
}

- (void)yrj_resumeTimer {
    
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate date]];
}

- (void)yrj_pauseTimer {
    
    if (![self isValid]) {
        
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]];
}

- (void)yrj_resumeTimerAfterTimeInterval:(NSTimeInterval)timeInterval {
    
    if (![self isValid]) {
        
        return ;
    }
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
}

@end
