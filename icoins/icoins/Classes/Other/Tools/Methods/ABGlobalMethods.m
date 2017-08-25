//
//  ABGlobalMethods.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABGlobalMethods.h"


// 用来保存唯一的单例对象
static id _instace;

@implementation ABGlobalMethods

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}


- (CGSize)getAutoLayoutWidthAndHeightWithLabel:(UILabel *)label font:(CGFloat)font{
    
    NSDictionary *labe2Attr = @{NSFontAttributeName:AdaptedFontSize(font)};
    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(label.ab_width, label.ab_height) options:NSStringDrawingTruncatesLastVisibleLine attributes:labe2Attr context:nil].size;
    return labelSize;
}
@end
