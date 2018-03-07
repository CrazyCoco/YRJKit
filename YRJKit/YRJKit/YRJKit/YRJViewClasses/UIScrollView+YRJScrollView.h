//
//  UIScrollView+YRJScrollView.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YRJScrollView)

/**
 滚动内容到顶部的动画
 */
- (void)yrj_scrollToTop;

/**
 滚动内容到底部的动画
 */
- (void)yrj_scrollToBottom;

/**
 滚动内容到左边的动画
 */
- (void)yrj_scrollToLeft;

/**
 滚动内容到右边的动画
 */
- (void)yrj_scrollToRight;

/**
 是否开启滚动内容到顶部的动画
 
 @param animated  Use animation.
 */
- (void)yrj_scrollToTopAnimated:(BOOL)animated;

/**
 是否开启滚动内容到底部的动画
 
 @param animated  Use animation.
 */
- (void)yrj_scrollToBottomAnimated:(BOOL)animated;

/**
 是否开启滚动内容到左边的动画
 
 @param animated  Use animation.
 */
- (void)yrj_scrollToLeftAnimated:(BOOL)animated;

/**
 是否开启滚动内容到右边的动画
 
 @param animated  Use animation.
 */
- (void)yrj_scrollToRightAnimated:(BOOL)animated;

@end
