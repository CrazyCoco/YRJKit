//
//  NSData+YRJData.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "NSData+YRJData.h"

#import <CommonCrypto/CommonCryptor.h>
#include <zlib.h>
#import "NSString+YRJString.h"

@implementation NSData (YRJData)

+ (NSData *)yrj_compressOriginalImage:(UIImage *)image
                  compressionQuality:(CGFloat)compressionQuality {
    
    NSData *yrj_data = UIImageJPEGRepresentation(image, compressionQuality);
    
    CGFloat yrj_dataKBytes = yrj_data.length / 1000.0;
    CGFloat yrj_maxQuality = 0.9f;
    CGFloat yrj_lastData   = yrj_dataKBytes;
    
    while (yrj_dataKBytes > compressionQuality && yrj_maxQuality > 0.01f) {
        
        yrj_maxQuality = yrj_maxQuality - 0.01f;
        
        yrj_data = UIImageJPEGRepresentation(image, yrj_maxQuality);
        
        yrj_dataKBytes = yrj_data.length / 1000.0;
        
        if (yrj_lastData == yrj_dataKBytes) {
            
            break;
            
        } else {
            
            yrj_lastData = yrj_dataKBytes;
        }
    }
    
    return yrj_data;
}


#pragma mark - Base 64
+ (NSData *)yrj_transformDataWithBase64EncodedString:(NSString *)string {
    
    if ([NSString yrj_checkEmptyWithString:string]) {
        
        return nil;
    }
    
    NSData *yrj_decodedData = [[NSData alloc] initWithBase64EncodedString:string
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [yrj_decodedData length] ? yrj_decodedData: nil;
}

+ (NSString *)yrj_transformBase64EncodedStringWithData:(NSData *)data
                                            wrapWidth:(YRJDataBaseType)wrapWidth {
    
    if (![data length]) {
        
        return nil;
    }
    
    NSString *yrj_dataEncodedString = nil;
    
    switch (wrapWidth) {
        case YRJDataBaseType64: {
            
            return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        } case YRJDataBaseType76: {
            
            return [data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            
        } default: {
            
            yrj_dataEncodedString = [data base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
        }
    }
    
    if (!wrapWidth || wrapWidth >= [yrj_dataEncodedString length]) {
        
        return yrj_dataEncodedString;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    
    NSMutableString *yrj_resultString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [yrj_dataEncodedString length]; i+= wrapWidth) {
        
        if (i + wrapWidth >= [yrj_dataEncodedString length]) {
            
            [yrj_resultString appendString:[yrj_dataEncodedString substringFromIndex:i]];
            
            break;
        }
        
        [yrj_resultString appendString:[yrj_dataEncodedString
                                       substringWithRange:NSMakeRange(i, wrapWidth)]];
        
        [yrj_resultString appendString:@"\r\n"];
    }
    
    return yrj_resultString;
}

#pragma mark - AES
- (NSData *)yrj_encryptedDataWithAESKey:(NSString *)key
                           encryptData:(NSData *)encryptData {
    
    NSData *yrj_keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t yrj_dataMoved;
    NSMutableData *yrj_encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus yrj_cryptorStatus = CCCrypt(kCCEncrypt,
                                               kCCAlgorithmAES128,
                                               kCCOptionPKCS7Padding,
                                               yrj_keyData.bytes,
                                               yrj_keyData.length,
                                               encryptData.bytes,
                                               self.bytes,
                                               self.length,
                                               yrj_encryptedData.mutableBytes,
                                               yrj_encryptedData.length,
                                               &yrj_dataMoved);
    
    if (yrj_cryptorStatus == kCCSuccess) {
        
        yrj_encryptedData.length = yrj_dataMoved;
        
        return yrj_encryptedData;
    }
    
    return nil;
}

- (NSData *)yrj_decryptedDataWithAESKey:(NSString *)key
                           decryptData:(NSData *)decryptData {
    
    NSData *yrj_keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t yrj_dataMoved;
    
    NSMutableData *yrj_decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus yrj_cryptorStatus = CCCrypt(kCCDecrypt,
                                               kCCAlgorithmAES128,
                                               kCCOptionPKCS7Padding,
                                               yrj_keyData.bytes,
                                               yrj_keyData.length,
                                               decryptData.bytes,
                                               self.bytes,
                                               self.length,
                                               yrj_decryptedData.mutableBytes,
                                               yrj_decryptedData.length,
                                               &yrj_dataMoved);
    
    if (yrj_cryptorStatus == kCCSuccess) {
        
        yrj_decryptedData.length = yrj_dataMoved;
        
        return yrj_decryptedData;
    }
    
    return nil;
}

#pragma mark - 3DES
- (NSData *)yrj_encryptedDataWith3DESKey:(NSString *)key
                            encryptData:(NSData *)encryptData {
    
    NSData *yrj_keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t yrj_dataMoved;
    NSMutableData *yrj_encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus yrj_cryptorStatus = CCCrypt(kCCEncrypt,
                                               kCCAlgorithm3DES,
                                               kCCOptionPKCS7Padding,
                                               yrj_keyData.bytes,
                                               yrj_keyData.length,
                                               encryptData.bytes,
                                               self.bytes,
                                               self.length,
                                               yrj_encryptedData.mutableBytes,
                                               yrj_encryptedData.length,
                                               &yrj_dataMoved);
    
    if (yrj_cryptorStatus == kCCSuccess) {
        
        yrj_encryptedData.length = yrj_dataMoved;
        
        return yrj_encryptedData;
    }
    
    return nil;
}

- (NSData *)yrj_decryptedDataWith3DEKey:(NSString *)key
                           decryptData:(NSData *)decryptData {
    
    NSData *yrj_keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t yrj_dataMoved;
    
    NSMutableData *yrj_decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus yrj_cryptorStatus = CCCrypt(kCCDecrypt,
                                               kCCAlgorithm3DES,
                                               kCCOptionPKCS7Padding,
                                               yrj_keyData.bytes,
                                               yrj_keyData.length,
                                               decryptData.bytes,
                                               self.bytes,
                                               self.length,
                                               yrj_decryptedData.mutableBytes,
                                               yrj_decryptedData.length,
                                               &yrj_dataMoved);
    
    if (yrj_cryptorStatus == kCCSuccess) {
        
        yrj_decryptedData.length = yrj_dataMoved;
        
        return yrj_decryptedData;
    }
    
    return nil;
}


- (NSData *)yrj_aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSData *)yrj_aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)yrj_utf8String {
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (NSString *)yrj_hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

+ (NSData *)yrj_dataWithHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}

static const char base64EncodingTable[64]
= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
};

- (NSString *)yrj_base64EncodedString {
    NSUInteger length = self.length;
    if (length == 0)
        return @"";
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL)
        return nil;
    
    const char *input = self.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[index + 3] = ((i + 2) < length)
        ? base64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output
                                                length:out_length
                                              encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

+ (NSData *)yrj_dataWithBase64EncodedString:(NSString *)base64EncodedString {
    NSInteger length = base64EncodedString.length;
    const char *string = [base64EncodedString cStringUsingEncoding:NSASCIIStringEncoding];
    if (string  == NULL)
        return nil;
    
    while (length > 0 && string[length - 1] == '=')
        length--;
    
    NSInteger outputLength = length * 3 / 4;
    NSMutableData *data = [NSMutableData dataWithLength:outputLength];
    if (data == nil)
        return nil;
    if (length == 0)
        return data;
    
    uint8_t *output = data.mutableBytes;
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < length) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < length ? string[inputPoint++] : 'A';
        char i3 = inputPoint < length ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (base64DecodingTable[i0] << 2)
        | (base64DecodingTable[i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i1] & 0xf) << 4)
            | (base64DecodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i2] & 0x3) << 6)
            | base64DecodingTable[i3];
        }
    }
    
    return data;
}

- (id)yrj_jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

- (NSData *)yrj_gzipInflate {
    if ([self length] == 0) return self;
    
    unsigned full_length = (unsigned)[self length];
    unsigned half_length = (unsigned)[self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData
                                   dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (unsigned)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15 + 32)) != Z_OK) return nil;
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else return nil;
}

- (NSData *)yrj_gzipDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16),
                     8, Z_DEFAULT_STRATEGY) != Z_OK)
        return nil;
    
    // 16K chunks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

- (NSData *)yrj_zlibInflate {
    if ([self length] == 0) return self;
    
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData
                                   dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)full_length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit(&strm) != Z_OK) return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else return nil;
}

- (NSData *)yrj_zlibDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit(&strm, Z_DEFAULT_COMPRESSION) != Z_OK) return nil;
    
    // 16K chuncks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

+ (NSData *)yrj_dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}


@end
