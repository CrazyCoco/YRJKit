//
//  NSNumber+YRJNumber.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (YRJNumber)

/**
 显示向最近的整数四舍五入取整的字符串
 
 @param number NSNumber
 @param digit NSUInteger, 限制位数
 @return NSString
 */
+ (NSString *)yrj_displayDecimalWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

/**
 显示向最近的整数四舍五入取整并添加了货币符号NSNumber的NSString
 
 @param number NSNumber
 @param digit NSUInteger, 限制位数
 @return NSString
 */
+ (NSString *)yrj_displayCurrencyWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

/**
 显示向最近的整数四舍五入取整并添加了百分号NSNumber的NSString
 
 @param number NSNumber
 @param digit NSUInteger, 限制位数
 @return NSString
 */
+ (NSString *)yrj_displayPercentWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

/**
 向最近的整数四舍五入取整
 
 @param number NSNumber
 @param digit NSUInteger, 限制位数
 @return NSNumber
 */
+ (NSNumber *)yrj_roundingWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

/**
 正无穷的四舍五入取整
 
 @param number NSNumber
 @param digit NSUInteger, 最大限制多少位数
 @return NSNumber
 */
+ (NSNumber *)yrj_roundCeilingWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

/**
 负无穷的四舍五入取整
 
 @param number NSNumber
 @param digit NSUInteger, 最大限制多少位数
 @return NSNumber
 */
+ (NSNumber *)yrj_roundFloorWithNumber:(NSNumber *)number digit:(NSUInteger)digit;

@end
