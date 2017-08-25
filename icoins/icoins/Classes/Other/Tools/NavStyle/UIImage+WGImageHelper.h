//
//  UIImage+WGImageHelper.h
//  setNavigationStyle
//
//  Created by Alex Williams on 2017/8/22.
//  Copyright © 2017年 xiaokedou. All rights reserved.
//

// 这个分类表示的是通过传入一个颜色或者其他返回一个image(导航条的背景image)

#import <UIKit/UIKit.h>

@interface UIImage (WGImageHelper)

// 通过颜色返回一张导航条的背景图片
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color;
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha;
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color rect:(CGRect)rect;
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color insets:(UIEdgeInsets)insets;
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha rect:(CGRect)rect;

@end
