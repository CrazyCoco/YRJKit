//
//  UIImage+YRJImage.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (YRJImage)

//截屏
+(instancetype)yrj_snapshotCurrentScreen;

//图片模糊效果
- (UIImage *)yrj_blur;

//高效添加圆角图片
- (UIImage*)yrj_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

//圆形图片
+ (UIImage *)yrj_GetRoundImagewithImage:(UIImage *)image;

//在图片上加居中的文字
- (UIImage *)yrj_imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor;

/**
 取图片某一像素点的颜色
 
 @param point 图片上的某一点
 @return 图片上这一点的颜色
 */
- (UIColor *)yrj_colorAtPixel:(CGPoint)point;

/**
 生成一个纯色的图片
 
 @param color 图片颜色
 @return 返回的纯色图片
 */
- (UIImage *)yrj_imageWithColor:(UIColor *)color;

/** 获得灰度图 */
- (UIImage *)yrj_convertToGrayImage;


+ (UIImage *)yrj_animatedImageWithAnimatedGIFData:(NSData *)theData;
+ (UIImage *)yrj_animatedImageWithAnimatedGIFURL:(NSURL *)theURL;


/** 合并两个图片为一个图片 */
+ (UIImage*)yrj_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

/** 压缩图片 最大字节大小为maxLength */
- (NSData *)yrj_compressWithMaxLength:(NSInteger)maxLength;

/** 纠正图片的方向 */
- (UIImage *)yrj_fixOrientation;

/** 按给定的方向旋转图片 */
- (UIImage*)yrj_rotate:(UIImageOrientation)orient;

/** 垂直翻转 */
- (UIImage *)yrj_flipVertical;

/** 水平翻转 */
- (UIImage *)yrj_flipHorizontal;

/** 将图片旋转degrees角度 */
- (UIImage *)yrj_imageRotatedByDegrees:(CGFloat)degrees;

/** 将图片旋转radians弧度 */
- (UIImage *)yrj_imageRotatedByRadians:(CGFloat)radians;


/** 截取当前image对象rect区域内的图像 */
- (UIImage *)yrj_subImageWithRect:(CGRect)rect;

/** 压缩图片至指定尺寸 */
- (UIImage *)yrj_rescaleImageToSize:(CGSize)size;

/** 压缩图片至指定像素 */
- (UIImage *)yrj_rescaleImageToPX:(CGFloat )toPX;

/** 在指定的size里面生成一个平铺的图片 */
- (UIImage *)yrj_getTiledImageWithSize:(CGSize)size;

/** UIView转化为UIImage */
+ (UIImage *)yrj_imageFromView:(UIView *)view;

- (UIImage *)yrj_imageCroppedToRect:(CGRect)rect;
- (UIImage *)yrj_imageScaledToSize:(CGSize)size;
- (UIImage *)yrj_imageScaledToFitSize:(CGSize)size;
- (UIImage *)yrj_imageScaledToFillSize:(CGSize)size;
- (UIImage *)yrj_imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit;

- (UIImage *)yrj_reflectedImageWithScale:(CGFloat)scale;
- (UIImage *)yrj_imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;

//带有阴影效果的图片
- (UIImage *)yrj_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
- (UIImage *)yrj_imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)yrj_imageWithAlpha:(CGFloat)alpha;
- (UIImage *)yrj_imageWithMask:(UIImage *)maskImage;

- (UIImage *)yrj_maskImageFromImageAlpha;

@end
