//
//  UIColor+QJCustomColor.h
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QJColorType) {
    kQJColorTypeRed = 1,
    kQJColorTypeGreen = 2,
    kQJColorTypeBlue = 3,
    kQJColorTypeAlpha = 4
};

@interface UIColor (QJCustomColor)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green; 
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 rgbHex;


- (CGColorSpaceModel) colorSpaceModel;
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) alpha;

- (UIColor *)reverseColor;
- (NSString *)printDetail;

- (UIColor *)up:(QJColorType)type num:(NSInteger)num;
- (UIColor *)down:(QJColorType)type num:(NSInteger)num;

+ (UIColor *)colorWithHexString:(NSString *)color;
@end
