//
//  UILabel+labelExtension.m
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import "UILabel+labelExtension.h"
#import <objc/runtime.h>

#define SizeScale ((ABScreenHeight > 568) ? ABScreenHeight/568 : 1)
@implementation UILabel (labelExtension)

+ (instancetype)labelWithFrame:(CGRect)Frame textColor:(NSString *)textColor backgroundColor:(NSString *)bgColor textFont:(CGFloat)size textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:Frame];
    label.textColor = [UIColor colorWithHexString:textColor];
    label.backgroundColor = [UIColor colorWithHexString:bgColor];
    label.textAlignment = textAlignment;
    label.font = AdaptedFontSize(size);
    label.text = text;
    return label;
}

+ (void)load {
    
    //xib创建
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    //代码initwithframe创建
    Method c = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method d = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(c, d);
}

#pragma mark - xib创建
- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
    }
    return self;
}

#pragma mark - 代码initwithframe创建
- (id)myInitWithFrame:(CGRect )rect {
    [self myInitWithFrame:rect];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
    }
    return self;
}




@end
