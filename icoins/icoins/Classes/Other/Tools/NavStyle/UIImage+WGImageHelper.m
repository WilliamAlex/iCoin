//
//  UIImage+WGImageHelper.m
//  setNavigationStyle
//
//  Created by Alex Williams on 2017/8/22.
//  Copyright © 2017年 xiaokedou. All rights reserved.
//

#import "UIImage+WGImageHelper.h"

@implementation UIImage (WGImageHelper)

- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color {

    return [self wg_updateImageWithTintColor:color alpha:1.0f];
}

- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha {

    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self wg_updateImageWithTintColor:color alpha:alpha rect:rect];
}

- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color rect:(CGRect)rect {

    return [self wg_updateImageWithTintColor:color alpha:1.0f rect:rect];
}

- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color insets:(UIEdgeInsets)insets {

    return [self wg_updateImageWithTintColor:color alpha:1.0f insets:insets];
}

- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets {

    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self wg_updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 初始化
- (UIImage *)wg_updateImageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha rect:(CGRect)rect {

    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    
    // 获取图片上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(ref, [color CGColor]);
    
    
    // 设置图形上下文的透明度
    CGContextSetAlpha(ref, alpha);
    
    // 设置混合模式
    CGContextSetBlendMode(ref, kCGBlendModeSourceAtop);
    
    // 填充当前rect
    CGContextFillRect(ref, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(ref);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
