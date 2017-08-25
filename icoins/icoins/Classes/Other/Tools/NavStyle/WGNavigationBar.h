//
//  UINavigationBar+WGNavigationBar.h
//  setNavigationStyle
//
//  Created by Alex Williams on 2017/8/22.
//  Copyright © 2017年 xiaokedou. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UIColor
@interface UIColor (WGSetNavTool)

// 设置UINavigationBar的默认颜色
+ (void)wg_setDefaultNavBarBarTintColor:(UIColor *)color;

// 设置UINavigationBar的默认背景图片
+ (void)wg_setDefaultNavBarBackgroundImage:(UIImage *)image;

// 设置UINavigationBar的tintColor的颜色
+ (void)wg_setDefaultNavBarTintColor:(UIColor *)color;

// 设置UINavigationBar上的文字的颜色
+ (void)wg_setDefaultNavBarTitleColor:(UIColor *)color;

// 设置状态栏样式
+ (void)wg_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

// 设置导航条上的阴影线是否隐藏
+ (void)wg_setDefaultNavBarShadowImageHidden:(BOOL)hidden;


@end

#pragma mark - UINavigationBar
@interface UINavigationBar (WGSetNavTool)


/**
 设置导航栏上所有BarButtonItem的透明度

 @param alpha 透明度
 @param hasSystemBackIndicator 是否显示返回指示器
 */
- (void)wg_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;


/**
 设置导航栏子安垂直方向上平移的距离

 @param translationY 设置平移的距离
 */
- (void)wg_setTranslationY:(CGFloat)translationY;


/**
 获取导航栏平移的距离

 @return 获取导航栏平移的距离
 */
- (CGFloat)wg_getTranslationY;

@end


#pragma mark - UIViewController
@interface UIViewController (WGSetNavTool)

// 记录当前控制器的导航条背景图片
- (void)wg_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)wg_navBarBackgroundImage;

// 记录当前控制器导航条的barTintColor
- (void)wg_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)wg_navBarBarTintColor;

//记录当前控制器导航条的backgroundAlpha
- (void)wg_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)wg_navBarBackgroundAlpha;

// 记录当前控制器导航条的tintColor
- (void)wg_setNavBarTintColor:(UIColor *)color;
- (UIColor *)wg_navBarTintColor;

// 记录当前控制器导航条上文字的titleColor
- (void)wg_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)wg_navBarTitleColor;

// 记录当前控制器的状态样式(statusBarStyle)
- (void)wg_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)wg_statusBarStyle;

// 记录当前控制器导航条上的shadowImage是否隐藏
- (void)wg_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)wg_navBarShadowImageHidden;

// 自定义当前控制器的导航条
- (void)wg_setCustomNavBar:(UINavigationBar *)navBar;

@end


















