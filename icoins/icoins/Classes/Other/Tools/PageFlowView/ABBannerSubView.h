//
//  ABBannerSubView.h
//  icoins
//
//  Created by williamalex on 2017/8/23.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABBannerSubView : UIView

// 主图
@property (nonatomic, strong) UIImageView *mainImageView;

// 用来变色View
@property (nonatomic, strong) UIView *coverView;

// 被点击的卡片
@property (nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, ABBannerSubView *cell);


@end
