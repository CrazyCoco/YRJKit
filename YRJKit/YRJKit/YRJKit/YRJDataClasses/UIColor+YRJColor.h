//
//  UIColor+YRJColor.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YRJColor)

/**
 * 使用16进制数字创建颜色
 */
+ (instancetype)yrj_colorWithHex:(uint32_t)hex;

/**
 * 随机颜色
 */
+ (instancetype)yrj_randomColor;

/**
 * RGB颜色
 */
+ (instancetype)yrj_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

/**
 十六进制字符串显示颜色
 
 @param color 十六进制字符串
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)yrj_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  @brief  渐变颜色
 *
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)yrj_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;


/**
 根据颜色生成图片
 
 @param size 图片尺寸
 @return 图片
 */
- (UIImage *)yrj_imageWithSize:(CGSize)size;

@end
