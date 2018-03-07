//
//  NSDictionary+YRJDictionary.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSDictionary+YRJDictionary.h"

@implementation NSDictionary (YRJDictionary)

+ (NSDictionary *)yrj_dictionaryWithURLString:(NSString *)urlString {
    
    NSString *yrj_queryString;
    
    if ([urlString containsString:@"?"]) {
        
        NSArray *yrj_urlArray = [urlString componentsSeparatedByString:@"?"];
        
        yrj_queryString = yrj_urlArray.lastObject;
    } else {
        
        yrj_queryString = urlString;
    }
    
    NSMutableDictionary *yrj_queryDictionary = [NSMutableDictionary dictionary];
    
    NSArray *yrj_parameters = [yrj_queryString componentsSeparatedByString:@"&"];
    
    [yrj_parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *yrj_contents = [obj componentsSeparatedByString:@"="];
        
        NSString *yrj_key   = yrj_contents.firstObject;
        NSString *yrj_value = yrj_contents.lastObject;
        
        yrj_value = [yrj_value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        if (yrj_key && yrj_value) {
            
            [yrj_queryDictionary setObject:yrj_value
                                   forKey:yrj_key];
        }
    }];
    
    return [yrj_queryDictionary copy];
}


@end
