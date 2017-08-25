//
//  ABDisplayTitleLabel.m
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABDisplayTitleLabel.h"

@implementation ABDisplayTitleLabel

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [_fillColor set];
    rect.size.width = rect.size.width * _progress;
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    [self setNeedsDisplay];
}

@end
