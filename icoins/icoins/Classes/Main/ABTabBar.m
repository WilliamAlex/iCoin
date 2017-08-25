//
//  ABTabBar.m
//  icoins
//
//  Created by williamalex on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABTabBar.h"
#define kTransform -150



@interface ABTabBar()


@property (nonatomic, weak) UIButton *creatBtn;
@property (nonatomic, weak) UIButton *insertBtn;

@end

@implementation ABTabBar

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        // 创建加好按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(plusBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    
    return self;
}

// 点击加号按钮
- (void)plusBtnDidClick:(UIButton *)button {

    self.plusBtn.selected = !self.plusBtn.selected;
    
    WS(ws);
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarCreateWalletOnClicked:)]) {
        [self.createDelegate tabBarCreateWalletOnClicked:self];
    }
    
    // 创建按钮
    UIButton *creatBtn = [UIButton buttonWithBackImage:nil image:nil title:@"创建钱包" target:self action:@selector(creatAWallet)];
    [creatBtn setBackgroundColor:[UIColor whiteColor]];
    [creatBtn setTitleColor:[UIColor colorWithHexString:@"414e5f"] forState:UIControlStateNormal];
    creatBtn.titleLabel.font = AdaptedFontSize(12);
    creatBtn.layer.cornerRadius = 32;
    creatBtn.clipsToBounds = YES;
    [keyWindow addSubview:creatBtn];
    self.creatBtn = creatBtn;
    [creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(keyWindow.mas_centerX).offset(AdaptedWidth(-15));
        make.bottom.equalTo(keyWindow.mas_bottom).offset(AdaptedHeight(71));
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    // 导入按钮
    UIButton *insertBtn = [UIButton buttonWithBackImage:nil image:nil title:@"导入钱包" target:self action:@selector(insertAWallet)];
    [insertBtn setBackgroundColor:[UIColor whiteColor]];
    [insertBtn setTitleColor:[UIColor colorWithHexString:@"414e5f"] forState:UIControlStateNormal];
    insertBtn.titleLabel.font = AdaptedFontSize(12);
    insertBtn.layer.cornerRadius = 32;
    insertBtn.clipsToBounds = YES;
    [keyWindow addSubview:insertBtn];
    self.insertBtn = insertBtn;
    [insertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(keyWindow.mas_centerX).offset(AdaptedWidth(15));
        make.bottom.equalTo(creatBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    //使用弹簧动画效果实现头像的位移
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:2 options:UIViewAnimationOptionCurveLinear animations:^{
        
        
        [ws.plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_click"] forState:UIControlStateDisabled];
        creatBtn.transform = CGAffineTransformTranslate(creatBtn.transform, 0, AdaptedHeight(kTransform));
        insertBtn.transform = CGAffineTransformTranslate(insertBtn.transform, 0, AdaptedHeight(kTransform));
    } completion:^(BOOL finished) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
    }];
}

// 布局tabBar
- (void)layoutSubviews {

    [super layoutSubviews];
    
    // 系统自带的按钮类型是UITabBarButton, 需要找到他们, 逼格重新设置位置, 将中间流出来
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.plusBtn.ab_size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    self.plusBtn.ab_centerX = self.ab_centerX;
    
    //调整发布按钮的中线点Y值
    self.plusBtn.ab_centerY = self.ab_height * 0.5 - AdaptedHeight(25) ;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"创建钱包";
    label.font = AdaptedFontSize(11);
    [label sizeToFit];
    label.textColor = [UIColor grayColor];
    label.ab_centerX = self.plusBtn.ab_centerX;
    label.ab_centerY = CGRectGetMaxY(self.plusBtn.frame) + AdaptedHeight(10);
    [self addSubview:label];
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            
            //每一个按钮的宽度==tabbar的五分之一
            btn.ab_width = self.ab_width / 5;
            
            btn.ab_x = btn.ab_width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

// 重写hitTest方法, 去监听加号按钮的点击, 目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    // self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    // 在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    // 是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}


- (void)creatAWallet {
    
    NSLog(@"创建钱包");
}

- (void)insertAWallet {
    
    NSLog(@"导入钱包");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    WS(ws);
    
    //使用弹簧动画效果实现头像的位移
    [UIView animateWithDuration:0.5f animations:^{
        
        [ws.plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        ws.creatBtn.transform = CGAffineTransformTranslate(ws.creatBtn.transform, 0, AdaptedHeight(-kTransform));
        ws.insertBtn.transform = CGAffineTransformTranslate(ws.insertBtn.transform, 0, AdaptedHeight(-kTransform));
    } completion:^(BOOL finished) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        [ws.creatBtn removeFromSuperview];
        [ws.insertBtn removeFromSuperview];
    }];
}


@end




























