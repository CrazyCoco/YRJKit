//
//  UIView+YRJInputControl.h
//  YRJKit
//
//  Created by YURENJIE on 2018/4/4.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

BOOL yrj_shouldChangeCharactersIn(id _Nullable target, NSRange range, NSString * _Nullable string);
void yrj_textDidChange(id _Nullable target);

typedef NS_ENUM(NSInteger, YRJTextControlType) {
    YRJTextControlType_none, //无限制
    
    YRJTextControlType_number,   //数字
    YRJTextControlType_letter,   //字母（包含大小写）
    YRJTextControlType_letterSmall,  //小写字母
    YRJTextControlType_letterBig,    //大写字母
    YRJTextControlType_number_letterSmall,   //数字+小写字母
    YRJTextControlType_number_letterBig, //数字+大写字母
    YRJTextControlType_number_letter,    //数字+字母
    
    YRJTextControlType_excludeInvisible, //去除不可见字符（包括空格、制表符、换页符等）
    YRJTextControlType_price,    //价格（小数点后最多输入两位）
};

@interface YRJInputControlProfile : NSObject

/**
 限制输入长度，NSUIntegerMax表示不限制（默认不限制）
 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 限制输入的文本类型（单选，在内部其实是配置了regularStr属性）
 */
@property (nonatomic, assign) YRJTextControlType textControlType;

/**
 限制输入的正则表达式字符串
 */
@property (nonatomic, copy, nullable) NSString *regularStr;

/**
 文本变化回调（observer为UITextFiled或UITextView）
 */
@property (nonatomic, copy, nullable) void(^textChanged)(id observe);

/**
 添加文本变化监听
 @param target 方法接收者
 @param action 方法（方法参数为UITextFiled或UITextView）
 */
- (void)addTargetOfTextChange:(id)target action:(SEL)action;



/**
 链式配置方法（对应属性配置）
 */
+ (YRJInputControlProfile *)creat;
- (YRJInputControlProfile *(^)(YRJTextControlType type))set_textControlType;
- (YRJInputControlProfile *(^)(NSString *regularStr))set_regularStr;
- (YRJInputControlProfile *(^)(NSUInteger maxLength))set_maxLength;
- (YRJInputControlProfile *(^)(void (^textChanged)(id observe)))set_textChanged;
- (YRJInputControlProfile *(^)(id target, SEL action))set_targetOfTextChange;



//键盘索引和键盘类型，当设置了 textControlType 内部会自动配置，当然你也可以自己配置
@property(nonatomic) UITextAutocorrectionType autocorrectionType;
@property(nonatomic) UIKeyboardType keyboardType;

//取消输入前回调的长度判断
@property (nonatomic, assign, readonly) BOOL cancelTextLengthControlBefore;
//文本变化方法体
@property (nonatomic, strong, nullable, readonly) NSInvocation *textChangeInvocation;

@end


@interface UITextField (YRJInputControl) <UITextFieldDelegate>

@property (nonatomic, strong, nullable) YRJInputControlProfile *yrj_inputCP;

@end


@interface UITextView (YRJInputControl) <UITextViewDelegate>

@property (nonatomic, strong, nullable) YRJInputControlProfile *yrj_inputCP;

@end

NS_ASSUME_NONNULL_END

/*
 使用实例
 textView.yb_inputCP = YBInputControlProfile.creat.set_textControlType(YBTextControlType_letter).set_maxLength(20).set_textChanged(^(id obj){
 NSLog(@"%@", [obj valueForKey:@"text"]);
 });
 
 */


#pragma mark UITextField 的使用
/*
 UITextField *textfield = [UITextField new];
 textfield.backgroundColor = [UIColor orangeColor];
 textfield.textColor = [UIColor whiteColor];
 textfield.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 44);
 [self.view addSubview:textfield];
 
 
 
 //链式语法使用
 //    textfield.yb_inputCP = YBInputControlProfile.creat.set_maxLength(10).set_textControlType(YBTextControlType_letter).set_textChanged(^(id obj){
 //        NSLog(@"%@", [obj valueForKey:@"text"]);
 //    });
 
 //常规方法使用
 YBInputControlProfile *profile = [YBInputControlProfile new];
 profile.maxLength = 10;
 profile.textControlType = YBTextControlType_letter;
 [profile addTargetOfTextChange:self action:@selector(textChange:)];
 textfield.yb_inputCP = profile;
 //    profile.regularStr = @"^[a-z]*$";
 
 //取消功能
 //textfield.yb_inputCP = nil;
 
 //同样可以按照以往的习惯，设置代理
 textfield.delegate = self;
 //** 特别注意
 //在给 textField 设置了非自身的 delegate，若实现了如下方法，将可能覆盖本框架的输入实时限制功能，对应可能会覆盖的函数是：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   解决方法是在其中调用框架方法（若没实现该方法就没什么影响）。
 */
