//
//  UINavigationBar+WGNavigationBar.m
//  setNavigationStyle
//
//  Created by Alex Williams on 2017/8/22.
//  Copyright © 2017年 xiaokedou. All rights reserved.
//

#import "WGNavigationBar.h"

#pragma mark - UINavigationBar
@implementation UINavigationBar (WGSetNavTool)

static char kWGBackgroundViewKey;
static char kWGBackgroundImageViewKey;
static int kWGNavBarBottom = 64;


// 给类动态添加方法
// 添加背景view
- (UIView *)backgroundView
{
    return (UIView *)objc_getAssociatedObject(self, &kWGBackgroundViewKey);
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    objc_setAssociatedObject(self, &kWGBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 添加背景图片
- (UIImageView *)backgroundImageView
{
    return (UIImageView *)objc_getAssociatedObject(self, &kWGBackgroundImageViewKey);
}

- (void)setBackgroundImageView:(UIImageView *)bgImageView
{
    objc_setAssociatedObject(self, &kWGBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置导航条的背景图片
- (void)wg_setBackgroundImage:(UIImage *)image {

    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil)
    {
        // 添加一张clear图片作为导航条的背景图片
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kWGNavBarBottom)];
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //  navigationBar的第0个子控件就是_UIBarBackground
        [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
    }
    self.backgroundImageView.image = image;
}

// 设置它的背景颜色
- (void)wg_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    if (self.backgroundView == nil)
    {
        // 添加一张clear图片作为导航条的背景图片
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kWGNavBarBottom)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //  navigationBar的第0个子控件就是_UIBarBackground
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// 设置导航条的alpha
- (void)wg_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
}

- (void)wg_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    // 这些key可以通过runtime遍历出来
    for (UIView *view in self.subviews)
    {
        if (hasSystemBackIndicator == YES)
        {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil)
            {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil)
            {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        } else {
            
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil)
                {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil)
                {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)wg_setTranslationY:(CGFloat)translationY
{
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)wg_getTranslationY
{
    return self.transform.ty;
}

// 使用runtime实现交换方法
+ (void)load {

    // 这里使用了单利, 只要是wg_开头的方法都只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL needSwizzleSelectors[1] = {
            
            @selector(setTitleTextAttributes:)
        };
        
        for (int i = 0; i < 1; i++) {
            
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"wg_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

// 设置导航条上的title的属性
- (void)wg_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self wg_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self wg_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self wg_setTitleTextAttributes:newTitleTextAttributes];
}

@end


#pragma mark - UIColor(可以自定义导航条上的属性)
@interface UIColor (SetNavTool)

// 默认设置的barTintColor
+ (UIColor *)defaultNavBarBarTintColor;

// 默认设置的TintColor
+ (UIColor *)defaultNavBarTintColor;

// 默认设置的titleCOlor
+ (UIColor *)defaultNavBarTitleColor;

// 默认设置的状态栏样式
+ (UIStatusBarStyle)defaultStatusBarStyle;

// 默认设置阴影线是否隐藏
+ (BOOL)defaultNavBarShadowImageHidden;

// 默认设置的导航条背景的透明度
+ (CGFloat)defaultNavBarBackgroundAlpha;

// 默认设置的过渡颜色
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;

// 默认设置的过渡透明度
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent;

@end


@implementation UIColor (WGSetNavTool)

static char kWGDefaultNavBarBarTintColorKey;
static char kWGDefaultNavBarBackgroundImageKey;
static char kWGDefaultNavBarTintColorKey;
static char kWGDefaultNavBarTitleColorKey;
static char kWGDefaultStatusBarStyleKey;
static char kWGDefaultNavBarShadowImageHiddenKey;

+ (UIColor *)defaultNavBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWGDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}

+ (void)wg_setDefaultNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWGDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)wg_setDefaultNavBarBackgroundImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &kWGDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWGDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)wg_setDefaultNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (UIColor *)defaultNavBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWGDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)wg_setDefaultNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kWGDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)wg_setDefaultStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kWGDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kWGDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)wg_setDefaultNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kWGDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha
{
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newged = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newged green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent
{
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}


@end


#pragma mark - UIViewController
@interface UIViewController (SetNavTool)

- (void)setPushToCurrentVCFinished:(BOOL)isFinished;

@end

#pragma mark - mark UINavigationController
@implementation UINavigationController (WGSetNavTool)

static CGFloat wgPopDuration = 0.12;
static int wgPopDisplayCount = 0;
static CGFloat wgPushDuration = 0.10;
static int wgPushDisplayCount = 0;


- (CGFloat)wgPopProgress
{
    CGFloat all = 60 * wgPopDuration;
    int current = MIN(all, wgPopDisplayCount);
    return current / all;
}

- (CGFloat)wgPushProgress
{
    CGFloat all = 60 * wgPushDuration;
    int current = MIN(all, wgPushDisplayCount);
    return current / all;
}

// 设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController wg_statusBarStyle];
}

// 背景图片
- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage
{
    [self.navigationBar wg_setBackgroundImage:backgroundImage];
}

// barTintColor
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor
{
    [self.navigationBar wg_setBackgroundColor:barTintColor];
}

// 导航条的透明度
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha
{
    [self.navigationBar wg_setBackgroundAlpha:barBackgroundAlpha];
}

// tintColor
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor
{
    self.navigationBar.tintColor = tintColor;
}

// 是否隐藏阴影线
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden
{
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}

// 导航条上的titleColor
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    // 改变 navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC wg_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC wg_navBarBarTintColor];
    UIColor *newBarTintColor = [UIColor middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    // 改变 navBarTintColor
    UIColor *fromTintColor = [fromVC wg_navBarTintColor];
    UIColor *toTintColor = [toVC wg_navBarTintColor];
    UIColor *newTintColor = [UIColor middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    // 改变 navBarTitleColor
    UIColor *fromTitleColor = [fromVC wg_navBarTitleColor];
    UIColor *toTitleColor = [toVC wg_navBarTitleColor];
    UIColor *newTitleColor = [UIColor middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // 改变 navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC wg_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC wg_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [UIColor middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

// 交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"wg_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)wg_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wgPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wgPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self wg_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)wg_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wgPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wgPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self wg_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// 在pop到当前控制器完成之前平滑的改变导航条的barTintColor
- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        wgPopDisplayCount += 1;
        CGFloat popProgress = [self wgPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

// push控制器
- (void)wg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wgPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:wgPushDuration];
    [CATransaction begin];
    [self wg_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// 平滑的改变导航条上的barTintColor, 在push到当前控制器完成之前
- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        wgPushDisplayCount += 1;
        CGFloat pushProgress = [self wgPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - 处理返回手势
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES)
    {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10)
        {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        else
        {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
//            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//                __strong typeof (self) pThis = weakSelf;
//                [pThis dealInteractionChanges:context];
//            }];
        }
        return YES;
    }
    
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// 处理手势返回中途停止等情况
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] wg_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] wg_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES)
    {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else
    {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)wg_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self wg_updateInteractiveTransition:percentComplete];
}


@end



@implementation UIViewController (WGSetNavTool)

static char kWGPushToCurrentVCFinishedKey;
static char kWGPushToNextVCFinishedKey;
static char kWGNavBarBackgroundImageKey;
static char kWGNavBarBarTintColorKey;
static char kWGNavBarBackgroundAlphaKey;
static char kWGNavBarTintColorKey;
static char kWGNavBarTitleColorKey;
static char kWGStatusBarStyleKey;
static char kWGNavBarShadowImageHiddenKey;
static char kWGCustomNavBarKey;

// 导航条上的barTintColor在push完成之前是不能够被改变的, 一定是在push完成之后才能改变
- (BOOL)pushToCurrentVcFinished {

    id isFinished = objc_getAssociatedObject(self, &kWGPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    
    objc_setAssociatedObject(self, &kWGPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 在push控制器完成之前是不能够设置导航条的barTintColor
- (BOOL)pushToNextVCFinished {
    
    id isFinished = objc_getAssociatedObject(self, &kWGPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToNextVCFinished:(BOOL)isFinished {
    
    objc_setAssociatedObject(self, &kWGPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 导航条的backgroundImage
- (UIImage *)wg_navBarBackgroundImage {
    
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWGNavBarBackgroundImageKey);
    image = (image == nil) ? [UIColor defaultNavBarBackgroundImage] : image;
    return image;
}

- (void)wg_setNavBarBackgroundImage:(UIImage *)image
{
    if ([[self wg_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wg_customNavBar];
        [navBar wg_setBackgroundImage:image];
    }
    else {
        objc_setAssociatedObject(self, &kWGNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// 导航条barTintColor
- (UIColor *)wg_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kWGNavBarBarTintColorKey);
    return (barTintColor != nil) ? barTintColor : [UIColor defaultNavBarBarTintColor];
}
- (void)wg_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wg_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wg_customNavBar];
        [navBar wg_setBackgroundColor:color];
    }
    else
    {
        if ([self pushToCurrentVcFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// 导航条的 _UIBarBackground alpha
- (CGFloat)wg_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kWGNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [UIColor defaultNavBarBackgroundAlpha];
    
}
- (void)wg_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kWGNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wg_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wg_customNavBar];
        [navBar wg_setBackgroundAlpha:alpha];
    }
    else
    {
        if ([self pushToCurrentVcFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// 导航条上的 tintColor
- (UIColor *)wg_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kWGNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [UIColor defaultNavBarTintColor];
}

- (void)wg_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wg_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wg_customNavBar];
        navBar.tintColor = color;
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// 导航条上的titleColor
- (UIColor *)wg_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kWGNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [UIColor defaultNavBarTitleColor];
}
- (void)wg_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kWGNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wg_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self wg_customNavBar];
        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)wg_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kWGStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [UIColor defaultStatusBarStyle];
}

- (void)wg_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kWGStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)wg_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kWGNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
    
}

- (BOOL)wg_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kWGNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [UIColor defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)wg_customNavBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kWGCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}

- (void)wg_setCustomNavBar:(UINavigationBar *)navBar
{
    objc_setAssociatedObject(self, &kWGCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[3] = {
                          @selector(viewWillAppear:),
                          @selector(viewWillDisappear:),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 3;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"wg_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)wg_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self wg_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self wg_navBarTitleColor]];
    }
    [self wg_viewWillAppear:animated];
}

- (void)wg_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:YES];
    }
    [self wg_viewWillDisappear:animated];
}

- (void)wg_viewDidAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self wg_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self wg_navBarBarTintColor]];
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self wg_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self wg_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self wg_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self wg_navBarShadowImageHidden]];
    }
    [self wg_viewDidAppear:animated];
}

- (BOOL)canUpdateNavigationBar
{
    if (self.navigationController && CGRectEqualToRect(self.view.frame, [UIScreen mainScreen].bounds)) {
        return YES;
    } else {
        return NO;
    }
}

@end







































