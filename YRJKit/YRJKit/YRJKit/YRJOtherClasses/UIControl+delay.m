//
//  UIControl+delay.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "UIControl+delay.h"

#import <objc/runtime.h>


//增加两个属性
static const char * UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char * UIControl_ignoreEvent = "UIControl_ignoreEvent";

@implementation UIControl (delay)

//时间间隔
- (NSTimeInterval)yrj_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setYrj_acceptEventInterval:(NSTimeInterval)yrj_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(yrj_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//是否响应事件的标志位
-(BOOL)yrj_ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}
-(void)setYrj_ignoreEvent:(BOOL)yrj_ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(yrj_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+(void)load
{
    //将系统的sendAction方法和自己实现的方法进行互换
    Method a=class_getInstanceMethod(self,@selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self,@selector(yrj_sendAction:to:forEvent:));
    method_exchangeImplementations(a,b);
}
//点击后会先进入这里
- (void)yrj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.yrj_ignoreEvent)//根据状态判断是否继续执行
        return;
    if (self.yrj_acceptEventInterval > 0)
    {
        self.yrj_ignoreEvent = YES;
        //周期性清空标志位
        [self performSelector:@selector(setYrj_ignoreEvent:) withObject:@(NO) afterDelay:self.yrj_acceptEventInterval];
    }
    //这里其实是系统的原来的sendAction to方法。
    [self yrj_sendAction:action to:target forEvent:event];
}

@end
