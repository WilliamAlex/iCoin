//
//  ABTitleDisplayViewController.h
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色渐变的样式
typedef NS_ENUM(NSUInteger, ABTitleColorGradientStyle) {
    
    kABTitleColorGradientStyleRGB,  // 默认是RGB样式
    kABTitleColorGradientStyleFill, // 填充样式
};

@interface ABTitleDisplayViewController : UIViewController

/**
 内容是否需要全屏显示
 YES:   全屏显示, 内容会占据整个屏幕, 会有穿透导航栏的效果, 需要设置tableView的额外滚动区域
 NO:   内容从标题下展示
 */
@property (nonatomic, assign) BOOL isFullScreen;

/**
 根据角标, 选中对应的控制器
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 如果_isFullScreen方法不好使, 我们可以设置整体的frame, 这包含了标题的滚动视图和内容视图
 
 @param contentBlock   回调
 */
- (void)setUpContentViewFrame:(void(^)(UIView *contentView))contentBlock;


/**
 刷新标题和整个界面(注意: 在调用之前必须要先确定添加了控制器)
 */
- (void)refreshDisplay;

/***********************************【顶部标题样式】********************************/
- (void)setUpTitleEffect:(void(^)(UIColor **titleScrollViewColor,UIColor **norColor,UIColor **selColor,UIFont **titleFont,CGFloat *titleHeight,CGFloat *titleWidth))titleEffectBlock;


/***********************************【下标样式】***********************************/
- (void)setUpUnderLineEffect:(void(^)(BOOL *isUnderLineDelayScroll,CGFloat *underLineH,UIColor **underLineColor, BOOL *isUnderLineEqualTitleWidth))underLineBlock;


/**********************************【字体缩放】************************************/
- (void)setUpTitleScale:(void(^)(CGFloat *titleScale))titleScaleBlock;


/**********************************【颜色渐变】************************************/
- (void)setUpTitleGradient:(void(^)(ABTitleColorGradientStyle *titleColorGradientStyle,UIColor **norColor,UIColor **selColor))titleGradientBlock;

/**********************************【遮盖】************************************/
- (void)setUpCoverEffect:(void(^)(UIColor **coverColor,CGFloat *coverCornerRadius))coverEffectBlock;

@end
