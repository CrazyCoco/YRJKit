//
//  NSNotificationCenter+YRJNotificationCenter.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSNotificationCenter+YRJNotificationCenter.h"

#include <pthread.h>

@implementation NSNotificationCenter (YRJNotificationCenter)

- (void)yrj_postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self yrj_postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)yrj_postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(_yrj_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)yrj_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self yrj_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)yrj_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self yrj_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)yrj_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(_yrj_postNotificationName:) withObject:info waitUntilDone:wait];
}

+ (void)_yrj_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)_yrj_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
