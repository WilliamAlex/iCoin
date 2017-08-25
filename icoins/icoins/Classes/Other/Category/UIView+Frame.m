//
//  UIView+Frame.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setAb_x:(CGFloat)ab_x {
    
    CGRect frame = self.frame;
    frame.origin.x = ab_x;
    self.frame = frame;
}
    
- (CGFloat)ab_x {
    
    return self.frame.origin.x;
}

- (void)setAb_y:(CGFloat)ab_y {

    CGRect frame = self.frame;
    frame.origin.y = ab_y;
    self.frame = frame;
}
    
- (CGFloat)ab_y {
    
    return self.frame.origin.y;
}
    
- (void)setAb_width:(CGFloat)ab_width {

    CGRect frame = self.frame;
    frame.size.width = ab_width;
    self.frame = frame;
}
    
- (CGFloat)ab_width {
    
    return self.frame.size.width;
}
    
- (void)setAb_height:(CGFloat)ab_height {

    CGRect frame = self.frame;
    frame.size.height = ab_height;
    self.frame= frame;
}
    
- (CGFloat)ab_height {
    
    return self.frame.size.height;
}
    
- (void)setAb_size:(CGSize)ab_size {
    
    CGRect frame = self.frame;
    frame.size = ab_size;
    self.frame = frame;
}
    
- (CGSize)ab_size {
    
    return self.frame.size;
}
    
- (void)setAb_centerX:(CGFloat)ab_centerX {

    CGPoint center = self.center;
    center.x = ab_centerX;
    self.center = center;
}
    
- (CGFloat)ab_centerX {
    
    return self.center.x;
}
    
- (void)setAb_centerY:(CGFloat)ab_centerY {
    
    CGPoint center = self.center;
    center.y = ab_centerY;
    self.center = center;
}
    
- (CGFloat)ab_centerY {
    
    return self.center.y;
}
    
    

    
@end


























