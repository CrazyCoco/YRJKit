//
//  NSFileManager+YRJFilrManager.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSFileManager+YRJFilrManager.h"
#import "NSURL+YRJUrl.h"
#import "NSString+YRJString.h"

@implementation NSFileManager (YRJFilrManager)

#pragma mark - 获取Cache Path
+ (NSString *)yrj_checkCachePathWithCacheName:(NSString *)cacheName {
    
    NSString *yrj_cachePath = [NSURL yrj_getCachesPathURL];
    
    yrj_cachePath = [yrj_cachePath stringByAppendingPathComponent:cacheName];
    
    if (![[self defaultManager] fileExistsAtPath:yrj_cachePath]) {
        
        [[self defaultManager] createDirectoryAtPath:yrj_cachePath
                         withIntermediateDirectories:YES
                                          attributes:nil
                                               error:nil];
    }
    
    return yrj_cachePath;
}

#pragma mark - 保存数据到Cache
+ (BOOL)yrj_saveDataCacheWithData:(NSData *)data
                      identifier:(NSString *)identifier {
    
    return [self yrj_saveDataCacheWithData:data
                                cacheName:@"CLDataCache"
                               identifier:identifier];
}

+ (BOOL)yrj_saveDataCacheWithData:(NSData *)data
                       cacheName:(NSString *)cacheName
                      identifier:(NSString *)identifier {
    
    NSString *yrj_cachePath = [self yrj_checkCachePathWithCacheName:cacheName];
    
    NSString *path = [yrj_cachePath stringByAppendingPathComponent:[NSString yrj_encodingMD5WithString:identifier]];
    
    return [data writeToFile:path
                  atomically:YES];
}

#pragma mark - 获取Cache的数据
+ (NSData *)yrj_getDataCacheWithIdentifier:(NSString *)identifier {
    
    return [self yrj_getDataCacheWithCacheName:@"CLDataCache"
                                   identifier:identifier];
}

+ (NSData *)yrj_getDataCacheWithCacheName:(NSString *)cacheName
                              identifier:(NSString *)identifier {
    
    NSString *yrj_cachePath     = [self yrj_checkCachePathWithCacheName:cacheName];
    NSString *yrj_identifierMD5 = [NSString yrj_encodingMD5WithString:identifier];
    NSString *yrj_dataPath      = [yrj_cachePath stringByAppendingPathComponent:yrj_identifierMD5];
    
    NSData *yrj_data = [NSData dataWithContentsOfFile:yrj_dataPath];
    
    [self yrj_appendFilePath:cacheName];
    
    return yrj_data;
}

#pragma mark - 删除Cache里的数据
+ (BOOL)yrj_removeDataWithCache {
    
    return [self yrj_removeDataWithCacheWithCacheName:@"CLDataCache"];
}

+ (BOOL)yrj_removeDataWithCacheWithCacheName:(NSString *)cacheName {
    
    NSString *yrj_cachePath = [self yrj_checkCachePathWithCacheName:cacheName];
    
    return [[self defaultManager] removeItemAtPath:yrj_cachePath
                                             error:nil];
}

#pragma mark - Document
+ (NSString *)yrj_appendFilePath:(NSString *)fileName {
    
    NSString *yrj_documentsPath = [NSURL yrj_getDocumentPathURL];
    
    NSString *yrj_filePath = [NSString stringWithFormat:@"%@/%@.archiver", yrj_documentsPath,fileName];
    
    return yrj_filePath;
}

+ (BOOL)yrj_saveDocumentWithObject:(id)object
                         fileName:(NSString *)fileName {
    
    NSString *yrj_documentsPath = [self yrj_appendFilePath:fileName];
    
    return [NSKeyedArchiver archiveRootObject:object
                                       toFile:yrj_documentsPath];
}

+ (id)yrj_getDocumentObjectWithFileName:(NSString *)fileName {
    
    NSString *yrj_documentsPath = [self yrj_appendFilePath:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:yrj_documentsPath];
}

+ (BOOL)yrj_removeDocumentObjectWithFileName:(NSString *)fileName {
    
    NSString *yrj_documentsPath = [self yrj_appendFilePath:fileName];
    
    return [[self defaultManager] removeItemAtPath:yrj_documentsPath
                                             error:nil];
}

+ (BOOL)yrj_checkFileExistWithFilePath:(NSString *)filePath {
    
    BOOL isDirectory;
    
    return [[self defaultManager] fileExistsAtPath:filePath
                                       isDirectory:&isDirectory];
}

@end
