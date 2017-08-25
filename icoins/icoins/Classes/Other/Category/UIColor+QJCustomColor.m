//
//  UIColor+QJCustomColor.m
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import "UIColor+QJCustomColor.h"

@implementation UIColor (QJCustomColor)

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)rgbHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.red, 0.0f), 1.0f);
    g = MIN(MAX(self.green, 0.0f), 1.0f);
    b = MIN(MAX(self.blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:	// We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (UIColor *)reverseColor
{
    float r= 1 - [self red];
    float g= 1 - [self green];
    float b= 1 - [self blue];
    float alpha= [self alpha];
    UIColor *rcolor = [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    return rcolor;
}

- (NSString *)printDetail
{
    float r= [self red];
    float g= [self green];
    float b= [self blue];
    float R= [self red] * 255;
    float G= [self green] *255;
    float B= [self blue] *255;
    float alpha= [self alpha];
    
    NSString *str = [NSString stringWithFormat:@"\nThis Color's Red:%.0f, Green:%.0f, Blue:%.0f, Alpha:%.0f\nDecimal red:%.4f green:%.4f blue:%.4f \nHexadecimal 0x%x%x%x",R,G,B,alpha,r,g,b,(int)R,(int)G,(int)B];
    return str;
}

- (UIColor *)up:(QJColorType)type num:(NSInteger)num
{
    float r = [self red] * 255.0;
    float g = [self green] * 255.0;
    float b = [self blue] * 255.0;
    float a = [self alpha];
    
    switch (type) {
        case 1:
            return WGRGBAColor(r+num, g, b, a);
            break;
        case 2:
            return WGRGBAColor(r, g+num, b, a);
            break;
        case 3:
            return WGRGBAColor(r, g, b+num, a);
            break;
        case 4:
            return WGRGBAColor(r, g, b, a+num/255.0);
            break;
        default:
            return self;
            break;
    }
}
- (UIColor *)down:(QJColorType)type num:(NSInteger)num
{
    float r = [self red] * 255.0;
    float g = [self green] * 255.0;
    float b = [self blue] * 255.0;
    float a = [self alpha];
    
    switch (type) {
        case 1:
            return WGRGBAColor(r-num, g, b, a);
            break;
        case 2:
            return WGRGBAColor(r, g-num, b, a);
            break;
        case 3:
            return WGRGBAColor(r, g, b-num, a);
            break;
        case 4:
            return WGRGBAColor(r, g, b, a-num/255.0);
            break;
        default:
            return self;
            break;
    }
}

#pragma mark -- 16进制Color转换
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
