//
//  UIButton+buttonExtension.h
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, QJButtonEdgeInsetsStyle) {
    QJButtonEdgeInsetsStyleTop, // image在上，label在下
    QJButtonEdgeInsetsStyleLeft, // image在左，label在右
    QJButtonEdgeInsetsStyleBottom, // image在下，label在上
    QJButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (buttonExtension)

/**
 快速定义一个button

 @param bgImg 背景图片
 @param img 按钮图片
 @param title 按钮标题
 @param target 监听者
 @param action 监听方法
 @return 按钮
 */
+ (UIButton *)buttonWithBackImage:(NSString *)bgImg image:(NSString *)img title:(NSString *)title target:(id)target action:(SEL)action;


/**
 设置button的titleLabel和imageView的布局样式，及间距

 @param style titleLabel和imageView的布局样式
 @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(QJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


/**
 快速创建一个普通按钮

 @param color 按钮的背景颜色
 @param textColor 按钮的文字颜色
 @param text 按钮文字
 @return <#return value description#>
 */
+ (UIButton *)buttonWithBackgroundColor:(NSString *)color textColor:(NSString *)textColor text:(NSString *)text target:(id)target action:(SEL)action;


@end
