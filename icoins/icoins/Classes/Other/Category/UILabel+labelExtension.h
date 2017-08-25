//
//  UILabel+labelExtension.h
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (labelExtension)


/**
 快速定义一个label

 @param Frame label的frame
 @param textColor 文字颜色
 @param bgColor 背景颜色
 @param size 大小
 @param textAlignment 位置
 @param text 文字
 @return 返回包装好的label
 */
+ (instancetype)labelWithFrame:(CGRect)Frame textColor:(NSString *)textColor backgroundColor:(NSString *)bgColor textFont:(CGFloat)size textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;



@end
