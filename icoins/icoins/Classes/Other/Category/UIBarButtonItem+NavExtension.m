//
//  UIBarButtonItem+NavExtension.m
//  SiLuJinHang
//
//  Created by Alex on 2016/12/27.
//  Copyright © 2016年 ShenZhenQinJin. All rights reserved.
//

#import "UIBarButtonItem+NavExtension.h"

@implementation UIBarButtonItem (NavExtension)

+ (instancetype)backItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage wg_imageWithOriginalRender:image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage wg_imageWithOriginalRender:highImage] forState:UIControlStateHighlighted];
    
    // 按钮文字大小自适应
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 45, 45);
    
    // 设置按钮的点击范围
    UIView *buttonView = [[UIView alloc] initWithFrame:backButton.bounds];
    [buttonView addSubview:backButton];
    return [[self alloc] initWithCustomView:backButton];
}

+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 28, 0, 0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonRightJumpItemWithImageName:(NSString *)jumpTitle target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
    [button setTitle:jumpTitle forState:UIControlStateNormal];
    button.titleLabel.font = AdaptedFontSize(12);
    [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    button.titleLabel.font = AdaptedFontSize(15);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    button.titleLabel.font = AdaptedFontSize(15);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40);
    
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selTitle forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

@end
