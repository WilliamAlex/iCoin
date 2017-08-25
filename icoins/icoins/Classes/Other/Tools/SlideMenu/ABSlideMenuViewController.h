//
//  ABSlideMenuViewController.h
//  icoins
//
//  Created by Alex Williams on 2017/8/19.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ABSlideMenu.h"

@interface ABSlideMenuViewController : UIViewController

// 主视图
@property (nonatomic, strong) UIViewController *rootViewController;

// 左视图
@property (nonatomic, strong) UIViewController *leftViewController;
    
// 右侧视图
@property (nonatomic, strong) UIViewController *rightViewController;

// 菜单的宽度
@property (nonatomic, assign, readonly) CGFloat menuWidth;
    
// 留白宽度
@property (nonatomic, assign, readonly) CGFloat emptyWidth;
    
// 是否允许滚动
//@property (nonatomic, assign) BOOL slideEnabled;
    
// 创建方法
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
    
//显示主视图
-(void)showRootViewControllerAnimated:(BOOL)animated;
    
//显示左侧菜单
-(void)showLeftViewControllerAnimated:(BOOL)animated;
    
//显示右侧菜单
-(void)showRightViewControllerAnimated:(BOOL)animated;
    
    
@end
