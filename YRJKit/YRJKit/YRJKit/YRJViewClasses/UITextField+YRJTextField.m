//
//  UITextField+YRJTextField.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/30.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "UITextField+YRJTextField.h"

@implementation UITextField (YRJTextField)


- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}


@end
