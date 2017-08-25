//
//  UIBarButtonItem+NavExtension.h
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NavExtension)

/**
 导航条上的返回按钮

 @param image 返回图片
 @param highImage 高亮图片
 @param target 监听者
 @param action 监听方法
 @return 返回按钮
 */
+ (instancetype)backItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**设置左边按钮*/
+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action;

/**设置右边按钮*/
+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action;

/**设置右边跳过按钮*/
+ (instancetype)barButtonRightJumpItemWithImageName:(NSString *)jumpTitle
                                         target:(id)target
                                         action:(SEL)action;

/** 设置按钮的普通状态下的文字*/
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                target:(id)target
                                action:(SEL)action;

/** 设置按钮的普通状态下以及选中状态下的文字*/
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action;

@end
