//
//  UIBarButtonItem+YRJBarButtonItem.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YRJBarButtonItem)

@property (nullable, nonatomic, copy) void (^actionBlock)(id);

@end
