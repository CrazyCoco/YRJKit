//
//  UIScrollView+YRJScrollView.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "UIScrollView+YRJScrollView.h"

@implementation UIScrollView (YRJScrollView)

- (void)yrj_scrollToTop {
    [self yrj_scrollToTopAnimated:YES];
}

- (void)yrj_scrollToBottom {
    [self yrj_scrollToBottomAnimated:YES];
}

- (void)yrj_scrollToLeft {
    [self yrj_scrollToLeftAnimated:YES];
}

- (void)yrj_scrollToRight {
    [self yrj_scrollToRightAnimated:YES];
}

- (void)yrj_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)yrj_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)yrj_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)yrj_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
