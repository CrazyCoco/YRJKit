//
//  UITableView+YRJTableView.h
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YRJTableView)

/**
 更新tableView数据

 @param block 更新完成回调
 */
- (void)yrj_updateWithBlock:(void (^)(UITableView *tableView))block;

/**
 滑动到指定位置

 @param row cell位置
 @param section 组位置
 @param scrollPosition scrollPosition description
 @param animated 动画
 */
- (void)yrj_scrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

/**
 插入cell

 @param row cell位置
 @param section 组位置
 @param animation 动画
 */
- (void)yrj_insertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 刷新cell

 @param row cell位置
 @param section 组位置
 @param animation 动画
 */
- (void)yrj_reloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 删除cell

 @param row 位置
 @param section 组位置
 @param animation 动画
 */
- (void)yrj_deleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 插入cell

 @param indexPath 位置
 @param animation 动画
 */
- (void)yrj_insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 刷新指定cell

 @param indexPath cell位置
 @param animation 动画
 */
- (void)yrj_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 删除cell

 @param indexPath cell位置
 @param animation 动画
 */
- (void)yrj_deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 增加组

 @param section 组
 @param animation 动画
 */
- (void)yrj_insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 删除组

 @param section 组
 @param animation 动画
 */
- (void)yrj_deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 刷新组

 @param section 组
 @param animation 动画
 */
- (void)yrj_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 清除选中动画

 @param animated animated description
 */
- (void)yrj_clearSelectedRowsAnimated:(BOOL)animated;

@end
