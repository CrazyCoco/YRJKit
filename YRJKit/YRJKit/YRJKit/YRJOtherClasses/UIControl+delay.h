//
//  UIControl+delay.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/9.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (delay)

@property (nonatomic, assign) NSTimeInterval yrj_acceptEventInterval;   // 可以用这个给重复点击加间隔

@end
