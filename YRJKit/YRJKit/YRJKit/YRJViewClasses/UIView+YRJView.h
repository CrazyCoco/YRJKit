//
//  UIView+YRJView.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapActionBlock)(UITapGestureRecognizer * _Nullable gestureRecoginzer);
typedef void (^LongPressActionBlock)(UILongPressGestureRecognizer * _Nullable gestureRecoginzer);

@interface UIView (YRJView)

/**
 创建完整视图层次结构的快照映像。
 */
- (nullable UIImage *)yrj_snapshotImage;

/**
 创建完整视图层次结构的快照映像。
 @ discussion的速度比“snapshotImage”快，但可能会导致屏幕更新。
 看到-[UIView drawViewHierarchyInRect:afterScreenUpdates:]以获取更多信息。
 */
- (nullable UIImage *)yrj_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 创建完整视图层次结构的快照PDF。
 */
- (nullable NSData *)yrj_snapshotPDF;

/**
 设置视图的快捷方式。层的影子
 
 @param color 阴影颜色
 @param offset 影子抵消
 @param radius 阴影半径
 */
- (void)yrj_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 删除所有子视图。
 
 @warning 不要在视图的drawRect:方法中调用此方法。
 */
- (void)yrj_removeAllSubviews;

/**
 返回视图的视图控制器(可能为nil)。
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/**
 在屏幕上返回可见的alpha，考虑到超视图和窗口。
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 将一个点从接收者的坐标系统转换为指定视图或窗口的一个点。
 
 @param point 在接收器的局部坐标系(边界)中指定的一点。
 @param view  要转换坐标系统点的视图或窗口。
 如果视图为nil，则该方法将转换为窗口基坐标。
 @return 这个点转换为坐标系的视图。
 */
- (CGPoint)yrj_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 从给定的视图或窗口的坐标系统转换到接收者的一个点。
 
 @param point 在局部坐标系(边界)中指定的一个点。
 @param view  在坐标系统中有点的视图或窗口。
 如果视图为nil，则该方法将从窗口基坐标转换。
 @return 该点转换为接收方的局部坐标系(边界)。
 */
- (CGPoint)yrj_convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 将一个矩形从接收器的坐标系转换到另一个视图或窗口。
 
 @param rect 在接收方的本地坐标系统(边界)中指定的矩形。
 @param view 是转换操作的目标。如果视图为nil，则该方法将转换为窗口基坐标。
 @return 转换后的矩形。
 */
- (CGRect)yrj_convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 将矩形从另一个视图或窗口的坐标系统转换成接收方的。
 
 @param rect 在本地坐标系统(边界)中指定的矩形。
 @param view 在其坐标系统中查看带有rect的视图或窗口。
 如果视图为nil，则该方法将从窗口基坐标转换。
 @return 转换后的矩形。
 */
- (CGRect)yrj_convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;



//xib加载视图
+ (instancetype _Nullable )yrj_loadViewFromNib;
+ (instancetype _Nullable )yrj_loadViewFromNibWithName:(NSString *_Nullable)nibName;
+ (instancetype _Nullable )yrj_loadViewFromNibWithName:(NSString *_Nullable)nibName owner:(id _Nullable )owner;
+ (instancetype _Nullable )yrj_loadViewFromNibWithName:(NSString *_Nullable)nibName owner:(id _Nullable )owner bundle:(NSBundle *_Nonnull)bundle;


/**
 * 给UIView 设置圆角
 */
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL  masksToBounds;

/**
 * 设置 view的 边框颜色(选择器和Hex颜色)
 * 以及 边框的宽度
 */
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable NSString  *   _Nullable borderHexRgb;
@property (strong,nonatomic) IBInspectable UIColor   * _Nullable borderColor;


/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)yrj_addTapActionWithBlock:(TapActionBlock _Nullable )block;

/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)yrj_addLongPressActionWithBlock:(LongPressActionBlock _Nullable )block;

@property (nonatomic) CGFloat left;        ///< 快捷方式 frame.origin.x.
@property (nonatomic) CGFloat top;         ///< 快捷方式 frame.origin.y
@property (nonatomic) CGFloat right;       ///< 快捷方式 frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< 快捷方式 frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< 快捷方式 frame.size.width.
@property (nonatomic) CGFloat height;      ///< 快捷方式 frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< 快捷方式 center.x
@property (nonatomic) CGFloat centerY;     ///< 快捷方式 center.y
@property (nonatomic) CGPoint origin;      ///< 快捷方式 frame.origin.
@property (nonatomic) CGSize  size;        ///< 快捷方式 frame.size.

+ (void)yrj_load;

@end
