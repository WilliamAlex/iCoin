//
//  ABAddressViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABAddressViewController.h"
#import "ABTransferViewController.h"
#import "ABReceivablesViewController.h"


@interface ABAddressViewController ()

@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation ABAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];

    // 添加子控制器
    [self addChildViewControllers];
    
    // 设置顶部样式(必须要添加控制器之后)
    [self setUpTitlesView];
}

- (void)setUpNav {

    // title
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"BTC"];
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    // 分享按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonRightItemWithImageName:@"icon_share" target:self action:@selector(shareBtnOnClicked)];
    
    // 返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"icon_return" target:self action:@selector(backBtnOnClicked)];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addChildViewControllers {
    
    // 收款
    ABReceivablesViewController *receivables = [[ABReceivablesViewController alloc] init];
    receivables.title = @"收款";
    [self addChildViewController:receivables];
    
    // 转账
    ABTransferViewController *transferVc = [[ABTransferViewController alloc] init];
    transferVc.title = @"转账";
    [self addChildViewController:transferVc];
}

- (void)setUpTitlesView {

    // 顶部样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *titleScrollViewColor = [UIColor colorWithHexString:@"ffffff"];
        *norColor = [UIColor colorWithHexString:@"999999"];
        *selColor = [UIColor colorWithHexString:@"01b9db"];
        *titleWidth = ABScreenWidth / self.childViewControllers.count;
    }];
    
    // 下标指示器
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        
        *isUnderLineEqualTitleWidth = YES;
        *underLineColor = [UIColor colorWithHexString:@"01b9db"];
    }];
}

- (void)shareBtnOnClicked {

    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"QQ" image:[UIImage imageNamed:@"icon_qq"] handler:^(ButtonView *buttonView){
            NSLog(@"点击QQ");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"icon_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"朋友圈" image:[UIImage imageNamed:@"icon_friend"] handler:^(ButtonView *buttonView){
            NSLog(@"点击朋友圈");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微博" image:[UIImage imageNamed:@"icon_weibo"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微博");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"QQ收藏" image:[UIImage imageNamed:@"icon_qqsc"] handler:^(ButtonView *buttonView){
            NSLog(@"点击QQ收藏");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信收藏" image:[UIImage imageNamed:@"icon_weixinsc"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信收藏");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"信息" image:[UIImage imageNamed:@"icon_message"] handler:^(ButtonView *buttonView){
            NSLog(@"点击信息");
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
}

- (void)backBtnOnClicked {

    [self.navigationController popViewControllerAnimated: YES];
}

@end
