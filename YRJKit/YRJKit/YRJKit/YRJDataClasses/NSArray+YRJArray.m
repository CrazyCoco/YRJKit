//
//  NSArray+YRJArray.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSArray+YRJArray.h"

#import "NSData+YRJData.h"

@implementation NSArray (YRJArray)

+ (instancetype)yrj_initSafeArrayWithObject:(id)object {
    
    if (object == nil) {
        
        return [self array];
        
    } else {
        
        return [self arrayWithObject:object];
    }
}

- (id)yrj_safeObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        
        return nil;
    } else {
        
        return [self objectAtIndex:index];
    }
}

- (NSArray *)yrj_safeArrayWithRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length   = range.length;
    
    if (location + length > self.count) {
        
        //超过了边界,就获取从loction开始所有的item
        if ((location + length) > self.count) {
            
            length = (self.count - location);
            
            return [self yrj_safeArrayWithRange:NSMakeRange(location, length)];
        }
        
        return nil;
        
    } else {
        
        return [self subarrayWithRange:range];
    }
}

- (NSUInteger)yrj_safeIndexOfObject:(id)object {
    
    if (object == nil) {
        
        return NSNotFound;
    } else {
        
        return [self indexOfObject:object];
    }
}

+ (NSArray *)yrj_getArrayWithPlistName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"plist"];
    
    return [NSArray arrayWithContentsOfFile:path];
}


+ (NSArray *)yrj_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

+ (NSArray *)yrj_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self yrj_arrayWithPlistData:data];
}

- (NSData *)yrj_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)yrj_plistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.yrj_utf8String;
    return nil;
}

- (id)yrj_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)yrj_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

- (NSString *)yrj_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (NSString *)yrj_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}


- (BOOL)yrj_isHaveObjc:(id _Nullable )obj{
    
    for (id a in self) {
        if ([a isEqual:obj]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)yrj_removesDuplicate{
    
    NSArray * newArr = [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
    return newArr;
    
}


@end
