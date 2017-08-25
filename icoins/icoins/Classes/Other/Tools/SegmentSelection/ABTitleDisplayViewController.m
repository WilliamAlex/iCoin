//
//  ABTitleDisplayViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABTitleDisplayViewController.h"
#import "ABDisplayTitleLabel.h"
#import "ABTitleCollectionViewFlowLayout.h"


@interface ABTitleDisplayViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    
    UIColor *_norColor;     // 普通状态下的颜色
    UIColor *_selColor;     // 选中状态下的颜色
}

// 下标宽度是否等于标签的宽度
@property (nonatomic, assign) BOOL isUnderLineEqualTitleWidth;

// 标签滚动视图的背景颜色
@property (nonatomic, strong) UIColor *titleScrollViewColor;

// 标签宽度
@property (nonatomic,assign) CGFloat titleWidth;

// 标签高度
@property (nonatomic,assign) CGFloat titleHeight;

// 正常的标题颜色
@property (nonatomic, strong) UIColor *norColor;

// 选中时的标题颜色
@property (nonatomic, strong) UIColor *selColor;

// 标题字体
@property (nonatomic, strong) UIFont *titleFont;

// 整体内容: 包含了标题和供电视图
@property (nonatomic, weak) UIView *contentView;

// 标签的滚动视图
@property (nonatomic, weak) UIScrollView *titleScrollView;

// 内容的滚动视图
@property (nonatomic, weak) UICollectionView *contentScrollView;

// 保存标签的数组
@property (nonatomic, strong) NSMutableArray *titleLabels;

// 所有标签宽度的数组
@property (nonatomic, strong) NSMutableArray *titleWidths;

// 下标指示器
@property (nonatomic, weak) UIView *underLine;

// 是否需要下标
@property (nonatomic, assign) BOOL isShowUnderLine;

// 字体是否渐变
@property (nonatomic, assign) BOOL isShowTitleGradient;

// 字体是否需要缩放的效果
@property (nonatomic, assign) BOOL isShowTitleScale;

// 是否显示遮盖
@property (nonatomic, assign) BOOL isShowTitleCover;

// 标签遮盖视图
@property (nonatomic, weak) UIView *coverView;

// 记录上一次内容滚动的视图偏移量
@property (nonatomic, assign) CGFloat lastOffSetX;

// 记录是否点击
@property (nonatomic, assign) BOOL isClickedTitle;

// 记录是否在动画
@property (nonatomic, assign) BOOL isAnimating;

// 是否初始化
@property (nonatomic, assign) BOOL isInitial;

// 标签间距
@property (nonatomic, assign) CGFloat titleMargin;

// 记录上一次选中的角标
@property (nonatomic, assign) NSInteger selIndex;

// 颜色渐变的样式
@property (nonatomic, assign) ABTitleColorGradientStyle titleColorGradientStyle;

// 字体的缩放比例
@property (nonatomic, assign) CGFloat titleScale;

// 是否延迟滚动下标
@property (nonatomic, assign) BOOL isDelayScroll;

// 遮盖的颜色
@property (nonatomic, strong) UIColor *coverColor;

// 遮盖的圆角半径
@property (nonatomic, assign) CGFloat coverCornerRadius;

// 下标颜色
@property (nonatomic, strong) UIColor *underLineColor;

// 下标高度
@property (nonatomic, assign) CGFloat underLineH;


/**
 开始颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/**
 完成颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;


@end

static NSString * const CELLID = @"CELLID";
@implementation ABTitleDisplayViewController

#pragma mark - 初始化
- (instancetype)init
{
    self =[super init];
    if (self) {
        
        [self initial];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initial];
    [super awakeFromNib];
}

- (void)initial {
    
    // 初始化标签栏高度
    _titleHeight = ABTitleScrollViewH;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 懒加载

// 标签字体
- (UIFont *)titleFont
{
    if (_titleFont == nil) {
        
        _titleFont = AdaptedFontSize(15);
    }
    return _titleFont;
}

// 标签宽度
- (NSMutableArray *)titleWidths {
    
    if (_titleWidths == nil) {
        
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

// 普通状态下颜色
- (UIColor *)norColor
{
    if (_norColor == nil) {
        
        _norColor = [UIColor blackColor];
    }
    return _norColor;
}

// 选中状态下的颜色
- (UIColor *)selColor
{
    if (_selColor == nil) {
        
        _selColor = [UIColor redColor];
    }
    
    return _selColor;
}

// 遮盖(标签背后的遮盖)
- (UIView *)coverView
{
    if (_coverView == nil) {
        
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = _coverColor? _coverColor : [UIColor lightGrayColor];
        coverView.layer.cornerRadius = _coverCornerRadius;
        [self.titleScrollView insertSubview:coverView atIndex:0];
        _coverView = coverView;
    }
    return _isShowTitleCover ? _coverView : nil;
}

// 下标指示器
- (UIView *)underLine
{
    if (_underLine == nil) {
        
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = _underLineColor? _underLineColor : [UIColor redColor];
        [self.titleScrollView addSubview:underLineView];
        _underLine = underLineView;
    }
    
    return _isShowUnderLine ? _underLine : nil;
}

// 保存标签的数组
- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

// 标签栏上的滚动视图
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.backgroundColor = _titleScrollViewColor? _titleScrollViewColor : [UIColor colorWithWhite:1 alpha:1.0];
        [self.contentView insertSubview:titleScrollView atIndex:0];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

// 内容滚动视图
- (UICollectionView *)contentScrollView
{
    if (_contentScrollView == nil) {
        
        ABTitleCollectionViewFlowLayout *layout = [[ABTitleCollectionViewFlowLayout alloc] init];
        UICollectionView *contentScrollView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentScrollView = contentScrollView;
        
        // 设置基本属性
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        _contentScrollView.scrollsToTop = NO;
        
        // 注册
        [_contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLID];
        _contentScrollView.backgroundColor = self.view.backgroundColor;
        [self.contentView insertSubview:contentScrollView belowSubview:self.titleScrollView];
    }
    
    return _contentScrollView;
}

// 整个视图的View
- (UIView *)contentView
{
    if (_contentView == nil) {
        
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self.view insertSubview:contentView aboveSubview:self.titleScrollView];
    }
    return _contentView;
}

#pragma mark - setter方法

// 字体缩放
- (void)setIsShowTitleScale:(BOOL)isShowTitleScale
{
    if (_isShowUnderLine) {
        
        // 抛出异常
        NSException *excption = [NSException exceptionWithName:@"ABDisplayViewControllerException" reason:@"字体的缩放效果和下标指示器不能同时使用" userInfo:nil];
        [excption raise];
    }
    
    _isShowTitleScale = isShowTitleScale;
}

// 下标指示器
- (void)setIsShowUnderLine:(BOOL)isShowUnderLine
{
    if (_isShowTitleScale) {
        
        // 抛出异常
        NSException *excption = [NSException exceptionWithName:@"ABDisplayViewControllerException" reason:@"下标指示器和字体的缩放不能同时使用" userInfo:nil];
        [excption raise];
    }
    
    _isShowUnderLine = isShowUnderLine;
}

// 标签栏的滚动颜色
- (void)setTitleScrollViewColor:(UIColor *)titleScrollViewColor
{
    _titleScrollViewColor = titleScrollViewColor;
    self.titleScrollView.backgroundColor = titleScrollViewColor;
}

// 是否全屏展示内容
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    self.contentView.frame = CGRectMake(0, 0, ABScreenWidth, ABScreenHeight);
}

// 整体内容的尺寸
- (void)setUpContentViewFrame:(void (^)(UIView *))contentBlock
{
    if (contentBlock) {
        
        contentBlock(self.contentView);
    }
}

// 一次性设置颜色的渐变
- (void)setUpTitleGradient:(void (^)(ABTitleColorGradientStyle *, UIColor *__autoreleasing *, UIColor *__autoreleasing *))titleGradientBlock
{
    
    _isShowTitleGradient = YES;
    UIColor *norColor;
    UIColor *selColor;
    if (titleGradientBlock) {
        
        titleGradientBlock(&_titleColorGradientStyle, &norColor, &selColor);
        if (norColor) {
            
            self.norColor = norColor;
        }
        if (selColor) {
            
            self.selColor = selColor;
        }
    }
    
    if (_titleColorGradientStyle == kABTitleColorGradientStyleFill && _titleWidth > 0) {
        
        @throw [NSException exceptionWithName:@"AB_Error: " reason:@"标题颜色的填充不需要设置宽度" userInfo:nil];
    }
}

// 一次性设置所有遮盖属性
- (void)setUpCoverEffect:(void (^)(UIColor **, CGFloat *))coverEffectBlock
{
    UIColor *color;
    
    _isShowTitleCover = YES;
    if (coverEffectBlock) {
        
        coverEffectBlock(&color,&_coverCornerRadius);
        if (color) {
            _coverColor = color;
        }
    }
}

// 一次性设置所有字体缩放属性
- (void)setUpTitleScale:(void(^)(CGFloat *titleScale))titleScaleBlock
{
    _isShowTitleScale = YES;
    if (_isShowUnderLine) {
        @throw [NSException exceptionWithName:@"AB_Error" reason:@"当前框架下标和字体缩放不能一起用" userInfo:nil];
    }
    
    if (titleScaleBlock) {
        titleScaleBlock(&_titleScale);
    }
}

// 一次性设置所有下标属性
- (void)setUpUnderLineEffect:(void(^)(BOOL *isUnderLineDelayScroll,CGFloat *underLineH,UIColor **underLineColor,BOOL *isUnderLineEqualTitleWidth))underLineBlock
{
    _isShowUnderLine = YES;
    
    if (_isShowTitleScale) {
        @throw [NSException exceptionWithName:@"AB_Error" reason:@"当前框架下标和字体缩放不能一起用" userInfo:nil];
    }
    
    UIColor *underLineColor;
    
    if (underLineBlock) {
        underLineBlock(&_isDelayScroll,&_underLineH,&underLineColor,&_isUnderLineEqualTitleWidth);
        
        _underLineColor = underLineColor;
    }
}

// 一次性设置所有标题属性
- (void)setUpTitleEffect:(void(^)(UIColor **titleScrollViewColor,UIColor **norColor,UIColor **selColor,UIFont **titleFont,CGFloat *titleHeight,CGFloat *titleWidth))titleEffectBlock{
    UIColor *titleScrollViewColor;
    UIColor *norColor;
    UIColor *selColor;
    UIFont *titleFont;
    if (titleEffectBlock) {
        titleEffectBlock(&titleScrollViewColor,&norColor,&selColor,&titleFont,&_titleHeight,&_titleWidth);
        if (norColor) {
            self.norColor = norColor;
        }
        if (selColor) {
            self.selColor = selColor;
        }
        if (titleScrollViewColor) {
            _titleScrollViewColor = titleScrollViewColor;
        }
        _titleFont = titleFont;
    }
    
    if (_titleColorGradientStyle == kABTitleColorGradientStyleFill && _titleWidth > 0) {
        @throw [NSException exceptionWithName:@"AB_ERROR" reason:@"标题颜色填充不需要设置标题宽度" userInfo:nil];
    }
}

#pragma mark - 控制器view生命周期方法
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (_isInitial == NO) {
        self.selectIndex = self.selectIndex;
        
        _isInitial = YES;
        
        CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
        
        CGFloat titleY = self.navigationController.navigationBarHidden == NO ?ABNavBarH:statusH;
        
        // 是否占据全屏
        if (_isFullScreen) {
            
            // 整体contentView尺寸
            self.contentView.frame = CGRectMake(0, 0, ABScreenWidth, ABScreenHeight);
            
            // 顶部标题View尺寸
            self.titleScrollView.frame = CGRectMake(0, titleY, ABScreenWidth, self.titleHeight);
            
            // 顶部内容View尺寸
            self.contentScrollView.frame = self.contentView.bounds;
            
            return;
        }
        
        if (self.contentView.frame.size.height == 0) {
            self.contentView.frame = CGRectMake(0, titleY, ABScreenWidth, ABScreenHeight - titleY);
        }
        
        // 顶部标题View尺寸
        self.titleScrollView.frame = CGRectMake(0, 0, ABScreenWidth, self.titleHeight);
        
        // 顶部内容View尺寸
        CGFloat contentY = CGRectGetMaxY(self.titleScrollView.frame);
        CGFloat contentH = self.contentView.ab_height - contentY;
        self.contentScrollView.frame = CGRectMake(0, contentY, ABScreenWidth, AdaptedHeight(contentH));
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        
        // 没有子控制器，不需要设置标题
        if (self.childViewControllers.count == 0) return;
        
        if (_titleColorGradientStyle == kABTitleColorGradientStyleFill || _titleWidth == 0) { // 填充样式才需要这样
            
            [self setUpTitleWidth];
        }
        
        [self setUpAllTitle];
    }
}

#pragma mark - 添加标题方法
// 计算所有标题宽度
- (void)setUpTitleWidth
{
    // 判断是否能占据整个屏幕
    NSUInteger count = self.childViewControllers.count;
    
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    
    CGFloat totalWidth = 0;
    
    // 计算所有标题的宽度
    for (NSString *title in titles) {
        
        if ([title isKindOfClass:[NSNull class]]) {
            // 抛异常
            NSException *excp = [NSException exceptionWithName:@"YZDisplayViewControllerException" reason:@"没有设置Controller.title属性，应该把子标题保存到对应子控制器中" userInfo:nil];
            [excp raise];
            
        }
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        
        CGFloat width = titleBounds.size.width;
        
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    if (totalWidth > ABScreenWidth) {
        
        _titleMargin = topTitleMargin;
        
        self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
        
        return;
    }
    
    CGFloat titleMargin = (ABScreenWidth - totalWidth) / (count + 1);
    
    _titleMargin = titleMargin < topTitleMargin? topTitleMargin: titleMargin;
    
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}

// 设置所有标题
- (void)setUpAllTitle
{
    // 遍历所有的子控制器
    NSUInteger count = self.childViewControllers.count;
    
    // 添加所有的标题
    CGFloat labelW = _titleWidth;
    CGFloat labelH = self.titleHeight;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        UILabel *label = [[ABDisplayTitleLabel alloc] init];
        
        label.tag = i;
        
        // 设置按钮的文字颜色
        label.textColor = self.norColor;
        
        label.font = self.titleFont;
        
        // 设置按钮标题
        label.text = vc.title;
        
        if (_titleColorGradientStyle == kABTitleColorGradientStyleFill || _titleWidth == 0) { // 填充样式才需要
            labelW = [self.titleWidths[i] floatValue];
            
            // 设置按钮位置
            UILabel *lastLabel = [self.titleLabels lastObject];
            
            labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        } else {
            
            labelX = i * labelW;
        }
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 保存到数组
        [self.titleLabels addObject:label];
        
        [_titleScrollView addSubview:label];
        
        if (i == _selectIndex) {
            [self titleClick:tap];
        }
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(count * ABScreenWidth, 0);
}

#pragma mark - 标题效果渐变方法
// 设置标题颜色渐变
- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(ABDisplayTitleLabel *)rightLabel leftLabel:(ABDisplayTitleLabel *)leftLabel
{
    if (_isShowTitleGradient == NO) return;
    
    // 获取右边缩放
    CGFloat rightSacle = offsetX / ABScreenWidth - leftLabel.tag;
    
    // 获取左边缩放比例
    CGFloat leftScale = 1 - rightSacle;
    
    // RGB渐变
    if (_titleColorGradientStyle == kABTitleColorGradientStyleRGB) {
        
        CGFloat r = _endR - _startR;
        CGFloat g = _endG - _startG;
        CGFloat b = _endB - _startB;
        
        // rightColor
        // 1 0 0
        UIColor *rightColor = [UIColor colorWithRed:_startR + r * rightSacle green:_startG + g * rightSacle blue:_startB + b * rightSacle alpha:1];
        
        // 0.3 0 0
        // 1 -> 0.3
        // leftColor
        UIColor *leftColor = [UIColor colorWithRed:_startR +  r * leftScale  green:_startG +  g * leftScale  blue:_startB +  b * leftScale alpha:1];
        
        // 右边颜色
        rightLabel.textColor = rightColor;
        
        // 左边颜色
        leftLabel.textColor = leftColor;
        return;
    }
    
    // 填充渐变
    if (_titleColorGradientStyle == kABTitleColorGradientStyleFill) {
        
        // 获取移动距离
        CGFloat offsetDelta = offsetX - _lastOffSetX;
        
        if (offsetDelta > 0) { // 往右边
            rightLabel.textColor = self.norColor;
            rightLabel.fillColor = self.selColor;
            rightLabel.progress = rightSacle;
            
            leftLabel.textColor = self.selColor;
            leftLabel.fillColor = self.norColor;
            leftLabel.progress = rightSacle;
            
        } else if(offsetDelta < 0){ // 往左边
            
            rightLabel.textColor = self.norColor;
            rightLabel.fillColor = self.selColor;
            rightLabel.progress = rightSacle;
            
            leftLabel.textColor = self.selColor;
            leftLabel.fillColor = self.norColor;
            leftLabel.progress = rightSacle;
            
        }
    }
}

// 标题缩放
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isShowTitleScale == NO) return;
    
    // 获取右边缩放
    CGFloat rightSacle = offsetX / ABScreenWidth - leftLabel.tag;
    
    CGFloat leftScale = 1 - rightSacle;
    
    CGFloat scaleTransform = _titleScale?_titleScale : ABTitleTransformScale;
    
    scaleTransform -= 1;
    
    // 缩放按钮
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    
    // 1 ~ 1.3
    rightLabel.transform = CGAffineTransformMakeScale(rightSacle * scaleTransform + 1, rightSacle * scaleTransform + 1);
}

// 获取两个标题按钮宽度差值
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

// 设置下标偏移
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isClickedTitle) return;
    
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.ab_x - leftLabel.ab_x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffSetX;
    
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / ABScreenWidth;
    
    // 宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / ABScreenWidth;
    
    self.underLine.ab_width += underLineWidth;
    self.underLine.ab_x += underLineTransformX;
}

// 设置遮盖偏移
- (void)setUpCoverOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isClickedTitle) return;
    
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.ab_x - leftLabel.ab_x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffSetX;
    
    // 计算当前下划线偏移量
    CGFloat coverTransformX = offsetDelta * centerDelta / ABScreenWidth;
    
    // 宽度递增偏移量
    CGFloat coverWidth = offsetDelta * widthDelta / ABScreenWidth;
    
    self.coverView.ab_width += coverWidth;
    self.coverView.ab_x += coverTransformX;
    
}

#pragma mark - 标题点击处理
- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    if (self.titleLabels.count) {
        
        UILabel *label = self.titleLabels[selectIndex];
        
        if (_selectIndex >= self.titleLabels.count) {
            @throw [NSException exceptionWithName:@"AB_ERROR" reason:@"选中控制器的角标越界" userInfo:nil];
        }
        
        [self titleClick:[label.gestureRecognizers firstObject]];
    }
}


// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 记录是否点击标题
    _isClickedTitle = YES;
    
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    // 获取当前角标
    NSInteger i = label.tag;
    
    // 选中label
    [self selectLabel:label];
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * ABScreenWidth;
    
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffSetX = offsetX;
    
    // 添加控制器
    UIViewController *vc = self.childViewControllers[i];
    
    // 判断控制器的view有没有加载，没有就加载，加载完在发送通知
    if (vc.view) {
        // 发出通知点击标题通知
        [[NSNotificationCenter defaultCenter] postNotificationName:ABDisplayViewClickOrScrollDidFinshNote  object:vc];
        
        // 发出重复点击标题通知
        if (_selIndex == i) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ABDisplayViewRepeatClickTitleNote object:vc];
        }
    }
    
    _selIndex = i;
    
    // 点击事件处理完成
    _isClickedTitle = NO;
}

- (void)selectLabel:(UILabel *)label
{
    
    for (ABDisplayTitleLabel *labelView in self.titleLabels) {
        
        if (label == labelView) continue;
        
        if (_isShowTitleGradient) {
            
            labelView.transform = CGAffineTransformIdentity;
        }
        
        labelView.textColor = self.norColor;
        
        if (_isShowTitleGradient && _titleColorGradientStyle == kABTitleColorGradientStyleFill) {
            
            labelView.fillColor = self.norColor;
            
            labelView.progress = 1;
        }
        
    }
    
    // 标题缩放
    if (_isShowTitleScale) {
        
        CGFloat scaleTransform = _titleScale?_titleScale:ABTitleTransformScale;
        
        label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    }
    
    // 修改标题选中颜色
    label.textColor = self.selColor;
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标的位置
    if (_isShowUnderLine) {
        [self setUpUnderLine:label];
    }
    
    // 设置cover
    if (_isShowTitleCover) {
        [self setUpCoverView:label];
    }
}

// 设置蒙版
- (void)setUpCoverView:(UILabel *)label
{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGFloat border = 5;
    CGFloat coverH = titleBounds.size.height + 2 * border;
    CGFloat coverW = titleBounds.size.width + 2 * border;
    
    self.coverView.ab_y = (label.ab_height - coverH) * 0.5;
    self.coverView.ab_height = coverH;
    
    
    // 最开始不需要动画
    if (self.coverView.ab_x == 0) {
        self.coverView.ab_width = coverW;
        
        self.coverView.ab_x = label.ab_x - border;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.ab_width = coverW;
        
        self.coverView.ab_x = label.ab_x - border;
    }];
}

// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label
{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGFloat underLineH = _underLineH?_underLineH: ABUnderLineH;
    
    self.underLine.ab_y = label.ab_height - underLineH;
    self.underLine.ab_height = underLineH;
    
    
    // 最开始不需要动画
    if (self.underLine.ab_x == 0) {
        if (_isUnderLineEqualTitleWidth) {
            self.underLine.ab_width = titleBounds.size.width;
        } else {
            self.underLine.ab_width = label.ab_width;
        }
        
        self.underLine.ab_centerX = label.ab_centerX;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        if (_isUnderLineEqualTitleWidth) {
            self.underLine.ab_width = titleBounds.size.width;
        } else {
            self.underLine.ab_width = label.ab_width;
        }
        self.underLine.ab_centerX = label.ab_centerX;
    }];
}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - ABScreenWidth * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ABScreenWidth + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - 刷新界面方法
// 更新界面
- (void)refreshDisplay
{
    if (self.childViewControllers.count == 0) {
        @throw [NSException exceptionWithName:@"YZ_ERROR" reason:@"请确定添加了所有子控制器" userInfo:nil];
    }
    
    // 清空之前所有标题
    [self.titleLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.titleLabels removeAllObjects];
    
    // 刷新表格
    [self.contentScrollView reloadData];
    
    // 重新设置标题
    if (_titleColorGradientStyle == kABTitleColorGradientStyleFill || _titleWidth == 0) {
        
        [self setUpTitleWidth];
    }
    
    [self setUpAllTitle];
    
    // 默认选中标题
    self.selectIndex = self.selectIndex;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    
    // 移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加控制器
    UIViewController *vc = self.childViewControllers[indexPath.row];
    
    vc.view.frame = CGRectMake(0, 0, self.contentScrollView.ab_width, self.contentScrollView.ab_height);
    
    CGFloat bottom = self.tabBarController == nil?0:49;
    CGFloat top = _isFullScreen?CGRectGetMaxY(self.titleScrollView.frame):0;
    if ([vc isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableViewVc = (UITableViewController *)vc;
        tableViewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    }
    
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

// 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger offsetXInt = offsetX;
    NSInteger screenWInt = ABScreenWidth;
    
    NSInteger extre = offsetXInt % screenWInt;
    if (extre > ABScreenWidth * 0.5) {
        // 往右边移动
        offsetX = offsetX + (ABScreenWidth - extre);
        _isAnimating = YES;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else if (extre < ABScreenWidth * 0.5 && extre > 0){
        _isAnimating = YES;
        // 往左边移动
        offsetX =  offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    // 获取角标
    NSInteger i = offsetX / ABScreenWidth;
    
    // 选中标题
    [self selectLabel:self.titleLabels[i]];
    
    // 取出对应控制器发出通知
    UIViewController *vc = self.childViewControllers[i];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ABDisplayViewClickOrScrollDidFinshNote object:vc];
}


// 监听滚动动画是否完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isAnimating = NO;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 点击和动画的时候不需要设置
    if (_isAnimating || self.titleLabels.count == 0) return;
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取左边角标
    NSInteger leftIndex = offsetX / ABScreenWidth;
    
    // 左边按钮
    ABDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    ABDisplayTitleLabel *rightLabel = nil;
    
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    // 字体放大
    [self setUpTitleScaleWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置下标偏移
    if (_isDelayScroll == NO) { // 延迟滚动，不需要移动下标
        
        [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    }
    
    // 设置遮盖偏移
    [self setUpCoverOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置标题渐变
    [self setUpTitleColorGradientWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 记录上一次的偏移量
    _lastOffSetX = offsetX;
}

#pragma mark - 颜色操作

- (void)setNorColor:(UIColor *)norColor
{
    _norColor = norColor;
    [self setupStartColor:norColor];
    
}

- (void)setSelColor:(UIColor *)selColor
{
    _selColor = selColor;
    [self setupEndColor:selColor];
}

- (void)setupStartColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _startR = components[0];
    _startG = components[1];
    _startB = components[2];
}

- (void)setupEndColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _endR = components[0];
    _endG = components[1];
    _endB = components[2];
}

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}




@end
