//
//  NSMutableAttributedString+YRJMutableAttributedString.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSMutableAttributedString+YRJMutableAttributedString.h"

@implementation NSMutableAttributedString (YRJMutableAttributedString)

+ (NSMutableAttributedString *)yrj_attributeStringWithSubffixString:(NSString *)subffixString subffixImage:(UIImage *)subffixImage {
    
    NSMutableAttributedString *yrj_mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    NSTextAttachment *yrj_backAttachment = [[NSTextAttachment alloc] init];
    
    yrj_backAttachment.image = subffixImage;
    yrj_backAttachment.bounds = CGRectMake(0, -2, subffixImage.size.width, subffixImage.size.height);
    
    NSAttributedString *yrj_backString = [NSAttributedString attributedStringWithAttachment:yrj_backAttachment];
    NSAttributedString *yrj_attributedString = [[NSAttributedString alloc] initWithString:subffixString];
    
    [yrj_mutableAttributedString appendAttributedString:yrj_backString];
    [yrj_mutableAttributedString appendAttributedString:yrj_attributedString];
    
    return yrj_mutableAttributedString;
}

+ (NSMutableAttributedString *)yrj_attributeStringWithSubffixString:(NSString *)subffixString subffixImages:(NSArray<UIImage *> *)subffixImages {
    
    NSMutableAttributedString *yrj_mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    [subffixImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSTextAttachment *yrj_backAttachment = [[NSTextAttachment alloc] init];
        
        yrj_backAttachment.image = obj;
        yrj_backAttachment.bounds = CGRectMake(0, -2, obj.size.width, obj.size.height);
        
        NSAttributedString *yrj_backString = [NSAttributedString attributedStringWithAttachment:yrj_backAttachment];
        
        [yrj_mutableAttributedString appendAttributedString:yrj_backString];
    }];
    
    NSAttributedString *yrj_attributedString = [[NSAttributedString alloc] initWithString:subffixString];
    
    [yrj_mutableAttributedString appendAttributedString:yrj_attributedString];
    
    return yrj_mutableAttributedString;
}

+ (NSMutableAttributedString *)yrj_attributeStringWithPrefixString:(NSString *)prefixString prefixImage:(UIImage *)prefixImage {
    
    NSMutableAttributedString *yrj_mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:prefixString];
    
    NSTextAttachment *yrj_backAttachment = [[NSTextAttachment alloc] init];
    
    yrj_backAttachment.image = prefixImage;
    yrj_backAttachment.bounds = CGRectMake(0, -2, prefixImage.size.width, prefixImage.size.height);
    
    NSAttributedString *yrj_backString = [NSAttributedString attributedStringWithAttachment:yrj_backAttachment];
    
    [yrj_mutableAttributedString appendAttributedString:yrj_backString];
    
    return yrj_mutableAttributedString;
}

+ (NSMutableAttributedString *)yrj_attributeStringWithPrefixString:(NSString *)prefixString prefixImages:(NSArray<UIImage *> *)prefixImages {
    
    NSMutableAttributedString *yrj_mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:prefixString];
    
    [prefixImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSTextAttachment *yrj_backAttachment = [[NSTextAttachment alloc] init];
        
        yrj_backAttachment.image = obj;
        yrj_backAttachment.bounds = CGRectMake(0, -2, obj.size.width, obj.size.height);
        
        NSAttributedString *yrj_backString = [NSAttributedString attributedStringWithAttachment:yrj_backAttachment];
        
        [yrj_mutableAttributedString appendAttributedString:yrj_backString];
    }];
    
    return yrj_mutableAttributedString;
}

+ (NSMutableAttributedString *)yrj_attributedStringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableAttributedString *yrj_attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [yrj_attributedString addAttribute:NSParagraphStyleAttributeName
                                value:paragraphStyle
                                range:NSMakeRange(0, [string length])];
    
    return yrj_attributedString;
}

+ (NSMutableAttributedString *)yrj_attributedStringWithAttributedString:(NSAttributedString *)attributedString lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableAttributedString *yrj_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [yrj_attributedString addAttribute:NSParagraphStyleAttributeName
                                value:paragraphStyle
                                range:NSMakeRange(0, [attributedString length])];
    
    return yrj_attributedString;
}


@end
