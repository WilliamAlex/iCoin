//
//  ABGlobalMethods.h
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABGlobalMethods : NSObject


+ (instancetype)shareManager;


- (CGSize)getAutoLayoutWidthAndHeightWithLabel:(UILabel *)label font:(CGFloat)font;

@end
