//
//  ABDisplayTitleLabel.h
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDisplayTitleLabel : UILabel

// 进度
@property (nonatomic, assign) CGFloat progress;

// 填充颜色
@property (nonatomic, strong) UIColor *fillColor;
@end
