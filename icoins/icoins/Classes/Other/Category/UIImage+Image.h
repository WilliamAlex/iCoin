//
//  UIImage+Image.h
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
    

/**
 根据颜色生成一张图片

 @param color 提供的颜色
 @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**防止图片被渲染*/
+ (UIImage *)wg_imageWithOriginalRender:(NSString *)imageName;

/**防止图片拉伸*/
+ (UIImage *)wg_resizeImageWithImageName:(NSString *)imageName;

@end
