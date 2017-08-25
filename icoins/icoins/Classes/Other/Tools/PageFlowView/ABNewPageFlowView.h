//
//  ABNewPageFlowView.h
//  icoins
//
//  Created by williamalex on 2017/8/23.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPagedFlowViewDataSource;
@protocol NewPagedFlowViewDelegate;


// 卡片滚动的方向
typedef NS_ENUM(NSInteger, NewPagedFlowViewOrientation) {

    NewPagedFlowViewOrientationHorizontal = 0,
    NewPagedFlowViewOrientationVertical
};

@interface ABNewPageFlowView : UIView <UIScrollViewDelegate>

// 默认是水平滚动的
@property (nonatomic, assign) NewPagedFlowViewOrientation orientation;

// 容器View
@property (nonatomic, strong) UIScrollView *scrollView;

// 是否需要重新加载
@property (nonatomic, assign) BOOL needsReload;

// 总页数
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,assign) NSRange visibleRange;

/**
 *  如果以后需要支持reuseIdentifier，这边就得使用字典类型了
 */
@property (nonatomic,strong) NSMutableArray *reusableCells;

/**
 *  指示器
 */
@property (nonatomic,retain)  UIPageControl *pageControl;

/**
 *  非当前页的透明比例
 */
@property (nonatomic, assign) CGFloat minimumPageAlpha;

/**
 左右间距,默认20
 */
@property (nonatomic, assign) CGFloat leftRightMargin;

/**
 上下间距,默认30
 */
@property (nonatomic, assign) CGFloat topBottomMargin;

/**
 *  是否开启自动滚动,默认为开启
 */
@property (nonatomic, assign) BOOL isOpenAutoScroll;

/**
 *  是否开启无限轮播,默认为开启
 */
@property (nonatomic, assign) BOOL isCarousel;

/**
 *  当前是第几页
 */
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/**
 *  定时器
 */
@property (nonatomic, weak) NSTimer *timer;

/**
 *  自动切换视图的时间,默认是5.0
 */
@property (nonatomic, assign) CGFloat autoTime;

/**
 *  原始页数
 */
@property (nonatomic, assign) NSInteger orginPageCount;

@property (nonatomic,assign)   id <NewPagedFlowViewDataSource>dataSource;
@property (nonatomic,assign)   id <NewPagedFlowViewDelegate>delegate;


/**
 *  刷新视图
 */
- (void)reloadData;

/**
 *  获取可重复使用的Cell
 *
 *
 */
- (UIView *)dequeueReusableCell;

/**
 *  滚动到指定的页面
 *
 *
 */
- (void)scrollToPage:(NSUInteger)pageNumber;

/**
 *  开启定时器,废弃
 */
//- (void)startTimer;

/**
 *  关闭定时器,关闭自动滚动
 */
- (void)stopTimer;



@end


@protocol  NewPagedFlowViewDelegate<NSObject>

@optional
/**
 *  当前显示cell的Size
 */
- (CGSize)sizeForPageInFlowView:(ABNewPageFlowView *)flowView;

/**
 *  滚动到了某一列
 */
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(ABNewPageFlowView *)flowView;

/**
 *  点击了第几个cell
 *
 *  @param subView 点击的控件
 *  @param subIndex    点击控件的index
 */
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex;

@end


@protocol NewPagedFlowViewDataSource <NSObject>

/**
 *  返回显示View的个数
 */
- (NSInteger)numberOfPagesInFlowView:(ABNewPageFlowView *)flowView;

/**
 *  给某一列设置属性
 */
- (UIView *)flowView:(ABNewPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index;


@end
































