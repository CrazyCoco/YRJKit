//
//  NSString+YRJString.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSString+YRJString.h"
#import "NSObject+YRJObject.h"
#import <CommonCrypto/CommonDigest.h>

static char yrj_base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

@implementation NSString (YRJString)

+ (NSString *)yrj_getNumberWithString:(NSString *)string {
    
    NSMutableString *yrj_string = [[NSMutableString alloc] init];
    
    for (NSInteger i = 0; i < string.length; i++) {
        
        NSString *yrj_numberString = [string substringWithRange:NSMakeRange(i, 1)];
        
        if ([yrj_numberString yrj_isNumber]) {
            
            [yrj_string appendString:yrj_numberString];
        }
    }
    
    return yrj_string;
}

+ (NSString *)yrj_getSecrectStringWithPhoneNumber:(NSString *)phoneNumber {
    
    if (![phoneNumber yrj_checkPhoneNumber]) {
        
        return nil;
    }
    
    NSMutableString *yrj_phoneNumberString = [NSMutableString stringWithString:phoneNumber];
    
    NSRange yrj_phoneNumberRange = NSMakeRange(3, 4);
    
    [yrj_phoneNumberString replaceCharactersInRange:yrj_phoneNumberRange
                                        withString:@"****"];
    
    return yrj_phoneNumberString;
}

+ (NSString *)yrj_getSecrectStringWithCardNumber:(NSString *)cardNumber {
    
    if (cardNumber.length < 8) {
        
        return nil;
    }
    
    NSMutableString *yrj_cardNumber = [NSMutableString stringWithString:cardNumber];
    
    NSRange yrj_cardRange = NSMakeRange(4, 8);
    
    [yrj_cardNumber replaceCharactersInRange:yrj_cardRange
                                 withString:@" **** **** "];
    
    return yrj_cardNumber;
}

- (CGFloat)yrj_heightWithFontSize:(CGFloat)fontSize
                           width:(CGFloat)width {
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    return  [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                            attributes:attributes
                               context:nil].size.height;
}

- (NSString *)yrj_removeUnwantedZero {
    
    if ([[self substringWithRange:NSMakeRange(self.length - 3, 3)] isEqualToString:@"000"]) {
        
        return [self substringWithRange:NSMakeRange(0, self.length - 4)]; // 多一个小数点
        
    } else if ([[self substringWithRange:NSMakeRange(self.length - 2, 2)] isEqualToString:@"00"]) {
        
        return [self substringWithRange:NSMakeRange(0, self.length - 2)];
        
    } else if ([[self substringWithRange:NSMakeRange(self.length - 1, 1)] isEqualToString:@"0"]) {
        
        return [self substringWithRange:NSMakeRange(0, self.length - 1)];
    } else {
        return self;
    }
}

- (NSString *)yrj_trimmedString {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)yrj_removeStringCharacterWithCharacter:(NSString *)character {
    
    return [self stringByReplacingOccurrencesOfString:character
                                           withString:@""];
}

+ (NSString *)yrj_stringMobileFormat:(NSString *)phoneNumber {
    
    return [self yrj_stringMobileFormat:phoneNumber
                             separator:@" "];
}

+ (NSString *)yrj_stringMobileFormat:(NSString *)phoneNumber
                          separator:(NSString *)separator {
    
    if ([phoneNumber yrj_checkPhoneNumber]) {
        
        NSMutableString *value = [[NSMutableString alloc] initWithString:phoneNumber];
        
        [value insertString:separator
                    atIndex:3];
        [value insertString:separator
                    atIndex:8];
        
        return value;
    }
    
    return nil;
}

+ (NSString *)yrj_stringUnitFormat:(CGFloat)value
                       unitString:(NSString *)unitString {
    
    if (value / 100000000 >= 1) {
        
        return [NSString stringWithFormat:@"%.0f%@", value / 100000000, unitString];
        
    } else if (value / 10000 >= 1 && value / 100000000 < 1) {
        
        return [NSString stringWithFormat:@"%.0f%@", value / 10000, unitString];
        
    } else {
        
        return [NSString stringWithFormat:@"%.0f", value];
    }
}


+ (CGSize)yrj_measureStringSizeWithString:(NSString *)string
                                    font:(UIFont *)font {
    
    if ([self yrj_checkEmptyWithString:string]) {
        
        return CGSizeZero;
    }
    
    CGSize measureSize = [string boundingRectWithSize:CGSizeMake(0, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
                                              context:nil].size;
    
    return measureSize;
}

+ (CGFloat)yrj_measureSingleLineStringWidthWithString:(NSString *)string
                                                font:(UIFont *)font {
    
    if ([self yrj_checkEmptyWithString:string]) {
        
        return 0;
    }
    
    CGSize measureSize = [string boundingRectWithSize:CGSizeMake(0, 0)
                                              options:NSStringDrawingUsesFontLeading
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
                                              context:nil].size;
    
    return ceil(measureSize.width);
}

+ (CGFloat)yrj_measureHeightWithMutilineString:(NSString *)string
                                         font:(UIFont *)font
                                        width:(CGFloat)width {
    
    if ([self yrj_checkEmptyWithString:string] || width <= 0) {
        
        return 0;
    }
    
    CGSize measureSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
                                              context:nil].size;
    
    return ceil(measureSize.height);
}

+ (NSString *)yrj_urlQueryStringWithDictionary:(NSDictionary *)dictionary {
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *key in [dictionary allKeys]) {
        
        if ([string length]) {
            
            [string appendString:@"&"];
        }
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[[dictionary objectForKey:key] description],
                                                                      NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}

+ (NSString *)yrj_jsonStringWithObject:(NSObject *)object {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (BOOL)yrj_checkEmptyWithString:(NSString *)string {
    
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [string length] == 0 || [string isEqualToString: @"(null)"]) {
        
        return YES;
    }
    return NO;
}

#pragma mark - 加密字符串方法
+ (NSString *)yrj_base64StringFromData:(NSData *)data
                               length:(NSUInteger)length {
    
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    
    NSMutableString *result;
    
    lentext = [data length];
    
    if (lentext < 1) {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    
    raw = [data bytes];
    
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext) {
                input[i] = raw[ix];
            }
            else {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++) {
            
            [result appendString: [NSString stringWithFormat: @"%c", yrj_base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length)) {
            
            charsonline = 0;
        }
    }
    return result;
}

+ (NSString *)yrj_encodingBase64WithString:(NSString *)string {
    
    NSData *yrj_stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *yrj_encodedString = [yrj_stringData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return yrj_encodedString;
}

+ (NSString *)yrj_decodedBase64WithString:(NSString *)string {
    
    NSData *yrj_stringData = [[NSData alloc] initWithBase64EncodedString:string
                                                                options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *yrj_decodedString = [[NSString alloc] initWithData:yrj_stringData
                                                       encoding:NSUTF8StringEncoding];
    return yrj_decodedString;
}

#pragma mark - MD5
+ (NSString *)yrj_encodingMD5WithString:(NSString *)string {
    
    if([self yrj_checkEmptyWithString:string]) {
        return nil;
    }
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [NSString stringWithString:outputString];
}

#pragma mark - 获取字符串首字母
+ (NSString *)yrj_transformPinYinWithString:(NSString *)string {
    
    NSMutableString *yrj_string = [string mutableCopy];
    
    CFStringTransform((CFMutableStringRef)yrj_string,
                      NULL,
                      kCFStringTransformMandarinLatin,
                      NO);
    
    CFStringTransform((CFMutableStringRef)yrj_string,
                      NULL,
                      kCFStringTransformStripDiacritics,
                      NO);
    
    return yrj_string;
}

#pragma mark - NSString获取首字母
+ (NSString *)yrj_getFirstCharactorWithString:(NSString *)string {
    
    NSString *yrj_pinYin = [[self yrj_transformPinYinWithString:string] uppercaseString];
    
    if (!yrj_pinYin || [self yrj_checkEmptyWithString:string]) {
        
        return @"#";
    }
    
    return [yrj_pinYin substringToIndex:1];
}

+ (NSString *)yrj_getFirstPinYinWithString:(NSString *)string {
    
    NSString *yrj_pinYin = [[self yrj_transformPinYinWithString:string] uppercaseString];
    
    if (!yrj_pinYin || [self yrj_checkEmptyWithString:string]) {
        
        return @"#";
    }
    
    yrj_pinYin = [yrj_pinYin substringToIndex:1];
    
    if ([yrj_pinYin compare:@"A"] == NSOrderedAscending || [yrj_pinYin compare:@"Z"] == NSOrderedDescending) {
        
        yrj_pinYin = @"#";
    }
    
    return yrj_pinYin;
}

#pragma mark - 正则表达式

- (BOOL)yrj_realContainDecimal {
    
    NSString *rules = @"^(\\-|\\+)?\\d+(\\.\\d+)?$";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 整数相关
- (BOOL)yrj_isNumber {
    
    NSString *rules = @"^[0-9]*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkMostNumber:(NSInteger)quantity {
    
    NSString *rules = [NSString stringWithFormat:@"^\\d{%ld}$", (long)quantity];
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkAtLeastNumber:(NSInteger)quantity {
    
    NSString *rules = [NSString stringWithFormat:@"^\\d{%ld,}$", (long)quantity];
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkLeastNumber:(NSInteger)leastNumber
                 mostNumber:(NSInteger)mostNumber {
    
    NSString *rules = [NSString stringWithFormat:@"^\\d{%ld,%ld}$", (long)leastNumber, (long)mostNumber];
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNotZeroStartNumber {
    
    NSString *rules = @"^(0|[1-9][0-9]*)$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNotZeroPositiveInteger {
    
    NSString *rules = @"^[1-9]\\d*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNotZeroNegativeInteger {
    
    NSString *rules = @"^-[1-9]\\d*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isPositiveInteger {
    
    NSString *rules = @"^\\d+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNegativeInteger {
    
    NSString *rules = @"^-[1-9]\\d*";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 浮点数相关
- (BOOL)yrj_isFloat {
    
    NSString *rules = @"^(-?\\d+)(\\.\\d+)?$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isPositiveFloat {
    
    NSString *rules = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNagativeFloat {
    
    NSString *rules = @"^-([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*)$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNotZeroStartNumberHaveOneOrTwoDecimal {
    
    NSString *rules = @"^([1-9][0-9]*)+(.[0-9]{1,2})?$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isHaveOneOrTwoDecimalPositiveOrNegative {
    
    NSString *rules = @"^(\\-)?\\d+(\\.\\d{1,2})?$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isPositiveRealHaveTwoDecimal {
    
    NSString *rules = @"^[0-9]+(.[0-9]{2})?$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isHaveOneOrThreeDecimalPositiveOrNegative {
    
    NSString *rules = @"^[0-9]+(.[0-9]{1,3})?$";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 字符串相关
- (BOOL)yrj_isChineseCharacter {
    
    NSString *rules = @"^[\u4e00-\u9fa5]{0,}$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isEnglishOrNumbers {
    
    NSString *rules = @"^[A-Za-z0-9]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_limitinglength:(NSInteger)fistRange
                lastRange:(NSInteger)lastRange {
    
    NSString *rules = [NSString stringWithFormat:@"^.{%ld,%ld}$", (long)fistRange, (long)lastRange];
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkString:(NSInteger)length {
    
    NSString *rules = @"^[A-Za-z0-9]+$";
    
    if (self.length == length) {
        
        return [self yrj_regularWithRule:rules];
    }
    
    return NO;
}

- (BOOL)yrj_isLettersString {
    
    NSString *rules = @"^[A-Za-z]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isCapitalLetters {
    
    NSString *rules = @"^[A-Z]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isLowercaseLetters {
    
    NSString *rules = @"^[a-z]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isNumbersOrLettersOrLineString {
    
    NSString *rules = @"^[A-Za-z0-9_]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isChineseCharacterOrEnglishOrNumbersOrLineString {
    
    NSString *rules = @"^[\u4E00-\u9FA5A-Za-z0-9_]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isDoesSpecialCharactersString {
    
    NSString *rules = @"^[\u4E00-\u9FA5A-Za-z0-9]+$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isContainSpecialCharacterString {
    
    NSString *rules = @"[^%&',;=?$\x22]+";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isContainCharacter:(NSString *)charater{
    
    NSString *rules = [NSString stringWithFormat:@"[^%@\x22]+", charater];
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_isLetterStar {
    
    NSString *rules = @"^[a-zA-Z][a-zA-Z0-9_]*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkStringIsStrong {
    
    NSString *rules = @"^\\w*(?=\\w*\\d)(?=\\w*[a-zA-Z])\\w*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkChineseCharacter {
    
    NSString *rules = @"[\u4e00-\u9fa5]";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkDoubleByteCharacters {
    
    NSString *rules = @"[^\\x00-\\xff]";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkBlankLines {
    
    NSString *rules = @"\\n\\s*\\r";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkFirstAndLastSpaceCharacters {
    
    NSString *rules = @"(^\\s*)|(\\s*$)";//@"^\\s*|\\s*$";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 号码相关
- (BOOL)yrj_checkPhoneNumber {
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    
    return [self yrj_regularWithRule:MOBILE] ||
    [self yrj_checkChinaMobelPhoneNumber] ||
    [self yrj_checkChinaUnicomPhoneNumber] ||
    [self yrj_checkChinaTelecomPhoneNumber];
}

- (BOOL)yrj_checkChinaMobelPhoneNumber {
    
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *rules = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkChinaUnicomPhoneNumber {
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *rules = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkChinaTelecomPhoneNumber {
    
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *rules = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkTelePhoneNumber {
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString *rules = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkFormatTelePhoneNumber {
    
    NSString *rules = @"^\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{7}|\\d{4}-\\d{8}";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 身份证相关
- (BOOL)yrj_checkIdentityCard {
    
    NSString *rules = @"^\\d{15}|\\d{18}$|^([0-9]){7,18}(x|X)?$";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 账号相关
- (BOOL)yrj_checkAccount {
    
    NSString *rules = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkPassword {
    
    NSString *rules = @"^[a-zA-Z]\\w{5,17}$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkStrongPassword:(NSInteger)briefest
                       longest:(NSInteger)longest {
    
    NSString *rules = [NSString stringWithFormat:@"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{%ld,%ld}$", (long)briefest, (long)longest];
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 日期相关
- (BOOL)yrj_checkChinaDateFormat {
    
    NSString *rules = @"^\\d{4}-\\d{1,2}-\\d{1,2}";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkAbroadDateFormat {
    
    NSString *rules = @"^\\d{1,2}-\\d{1,2}-\\d{4}";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkMonth {
    
    NSString *rules = @"^(0?[1-9]|1[0-2])$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkDay {
    
    NSString *rules = @"^((0?[1-9])|((1|2)[0-9])|30|31)$";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - 特殊正则
- (BOOL)yrj_checkEmailAddress {
    
    NSString *rules = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkDomainName {
    
    NSString *rules = @"[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkURL {
    
    NSString *rules = @"[a-zA-z]+://[^\\s]*";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkXMLFile {
    
    NSString *rules = @"^([a-zA-Z]+-?)+[a-zA-Z0-9]+\\.[x|X][m|M][l|L]$";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkHTMLSign {
    
    NSString *rules = @"<(\\S*?)[^>]*>.*?</\\1>|<.*? />";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkQQNumber {
    
    NSString *rules = @"[1-9][0-9]{4}";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkPostalCode {
    
    NSString *rules = @"[1-9]\\d{5}(?!\\d)";
    
    return [self yrj_regularWithRule:rules];
}

- (BOOL)yrj_checkIPv4InternetProtocol {
    
    NSString *rules = @"((?:(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d))";
    
    return [self yrj_regularWithRule:rules];
}

#pragma mark - Rule Method
- (BOOL)yrj_regularWithRule:(NSString *)rule {
    
    NSPredicate *stringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rule];
    
    return [stringPredicate evaluateWithObject:self];
}

+ (NSString *)yrj_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

@end
