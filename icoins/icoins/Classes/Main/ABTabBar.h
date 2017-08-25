//
//  ABTabBar.h
//  icoins
//
//  Created by williamalex on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABTabBar;

@protocol ABTabBarDeleagete <NSObject>

@optional
// 中间创建钱包的tabBar被点击
- (void)tabBarCreateWalletOnClicked:(ABTabBar *)tabBar;

@end

@interface ABTabBar : UITabBar

// 加号按钮
@property (nonatomic, weak) UIButton *plusBtn;

// 代理属性
@property (nonatomic, weak) id<ABTabBarDeleagete>createDelegate;
@end
