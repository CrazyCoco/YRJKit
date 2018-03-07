//
//  NSNumber+YRJNumber.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSNumber+YRJNumber.h"

@implementation NSNumber (YRJNumber)

#pragma mark - NSNumber显示字符串
+ (NSString *)yrj_displayDecimalWithNumber:(NSNumber *)number digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundHalfUp];
    
    yrj_numberFormatter.numberStyle           = NSNumberFormatterDecimalStyle;
    yrj_numberFormatter.maximumFractionDigits = digit;
    
    return [yrj_numberFormatter stringFromNumber:number];
}

+ (NSString *)yrj_displayCurrencyWithNumber:(NSNumber *)number digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundHalfUp];
    
    yrj_numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    yrj_numberFormatter.maximumFractionDigits = digit;
    
    return [yrj_numberFormatter stringFromNumber:number];
}

+ (NSString *)yrj_displayPercentWithNumber:(NSNumber *)number
                                     digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundHalfUp];
    
    yrj_numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    yrj_numberFormatter.maximumFractionDigits = digit;
    
    return [yrj_numberFormatter stringFromNumber:number];
}

#pragma mark - NSNumber四舍五入
+ (NSNumber *)yrj_roundingWithNumber:(NSNumber *)number digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundHalfUp];
    
    yrj_numberFormatter.maximumFractionDigits = digit;
    yrj_numberFormatter.minimumFractionDigits = digit;
    
    NSString *yrj_numberString = [yrj_numberFormatter stringFromNumber:number];
    
    return [NSNumber numberWithDouble:[yrj_numberString doubleValue]];
}

+ (NSNumber *)yrj_roundCeilingWithNumber:(NSNumber *)number digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundCeiling];
    
    yrj_numberFormatter.maximumFractionDigits = digit;
    
    NSString *yrj_numberString = [yrj_numberFormatter stringFromNumber:number];
    
    return [NSNumber numberWithDouble:[yrj_numberString doubleValue]];
}

+ (NSNumber *)yrj_roundFloorWithNumber:(NSNumber *)number digit:(NSUInteger)digit {
    
    NSNumberFormatter *yrj_numberFormatter = [self yrj_numberFormatterWithRoundingMode:NSNumberFormatterRoundFloor];
    
    yrj_numberFormatter.maximumFractionDigits = digit;
    
    NSString *yrj_numberString = [yrj_numberFormatter stringFromNumber:number];
    
    return [NSNumber numberWithDouble:[yrj_numberString doubleValue]];
}

+ (NSNumberFormatter *)yrj_numberFormatterWithRoundingMode:(NSNumberFormatterRoundingMode)roundingMode {
    
    NSNumberFormatter *yrj_numberFormatter = [[NSNumberFormatter alloc] init];
    
    yrj_numberFormatter.roundingMode = roundingMode;
    
    return yrj_numberFormatter;
}

@end
