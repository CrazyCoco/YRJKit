//
//  NSData+YRJData.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YRJDataBaseType) {
    
    YRJDataBaseType64 = 64,
    YRJDataBaseType76 = 76
};

@interface NSData (YRJData)

/**
 将指定的图片转成NSData, 可输入指定压缩比例
 
 @param image UIImage
 @param compressionQuality 压缩比例
 @return NSData
 */
+ (NSData *_Nullable)yrj_compressOriginalImage:(UIImage *_Nullable)image
                  compressionQuality:(CGFloat)compressionQuality;


#pragma mark - Base 64加密/解密
/**
 将Base 64的字符串转成NSData
 
 @param string NSString
 @return NSData
 */
+ (NSData *_Nullable)yrj_transformDataWithBase64EncodedString:(NSString *_Nullable)string;

/**
 将指定的NSData转成64或76的字符串
 
 @param data NSData
 @param wrapWidth CLDataBaseType
 @return NSString
 */
+ (NSString *_Nullable)yrj_transformBase64EncodedStringWithData:(NSData *_Nullable)data
                                            wrapWidth:(YRJDataBaseType)wrapWidth;

#pragma mark - AES加密/解密
/**
 利用AES加密NSData
 
 @param key NSString
 @param encryptData NSData
 @return NSData
 */
- (NSData *_Nullable)yrj_encryptedDataWithAESKey:(NSString *_Nullable)key
                                     encryptData:(NSData *_Nullable)encryptData;

/**
 利用AES解密NSData
 
 @param key NSString
 @param decryptData NSData
 @return NSData
 */
- (NSData *_Nullable)yrj_decryptedDataWithAESKey:(NSString *_Nullable)key
                                     decryptData:(NSData *_Nullable)decryptData;

#pragma mark - 3DES加密/解密
/**
 利用3DES加密NSData
 
 @param key NSString
 @param encryptData NSData
 @return NSData
 */
- (NSData *_Nullable)yrj_encryptedDataWith3DESKey:(NSString *_Nullable)key
                                      encryptData:(NSData *_Nullable)encryptData;

/**
 利用3DES解密NSData
 
 @param key NSString
 @param decryptData NSData
 @return NSData
 */
- (NSData *_Nullable)yrj_decryptedDataWith3DEKey:(NSString *_Nullable)key
                                     decryptData:(NSData *_Nullable)decryptData;

#pragma mark - Encrypt and Decrypt

/**
 使用AES返回加密的NSData。
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)yrj_aes256EncryptWithKey:(NSData *_Nullable)key iv:(nullable NSData *)iv;

/**
 使用AES返回解密的NSData。
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)yrj_aes256DecryptWithkey:(NSData *_Nullable)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode

/**
 返回在UTF8中解码的字符串
 */
- (nullable NSString *)yrj_utf8String;

/**
 在十六进制中返回一个大写的NSString
 */
- (nullable NSString *)yrj_hexString;

/**
 从十六进制字符串返回一个NSData
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)yrj_dataWithHexString:(NSString *_Nullable)hexString;

/**
 返回base64编码的NSString
 */
- (nullable NSString *)yrj_base64EncodedString;

/**
 从base64编码的字符串返回一个NSData
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)yrj_dataWithBase64EncodedString:(NSString *_Nullable)base64EncodedString;

/**
 返回一个NSDictionary或NSArray来解码自己。
 如果出现错误，返回nil
 */
- (nullable id)yrj_jsonValueDecoded;


#pragma mark - Inflate and deflate

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (nullable NSData *)yrj_gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)yrj_gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (nullable NSData *)yrj_zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)yrj_zlibDeflate;


#pragma mark - Others

/**
 从主包中的文件创建数据(类似于[UIImage imageNamed:])。
 
 @param name The file name (in main bundle).
 
 @return A new data create from the file.
 */
+ (nullable NSData *)yrj_dataNamed:(NSString *_Nullable)name;


@end
