//
//  ABManagerWalletsViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABManagerWalletsViewController.h"
#import "ABCoinViewController.h"


@interface ABManagerWalletsViewController ()

@end

@implementation ABManagerWalletsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    // 添加子控制器
    [self addChildViewControllers];
    
    // 添加顶部样式
    [self setUpTitlesView];
    
    // 底部两个按钮
    [self setUpWalletButtons];
}

- (void)setUpNav {
    
    // title
    self.navigationItem.title = @"";
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"管理钱包"];
    self.navigationItem.titleView = titleLabel;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"icon_return" target:self action:@selector(back)];
}

- (void)addChildViewControllers {

    // BTC
    ABCoinViewController *BTCVc = [[ABCoinViewController alloc] init];
    BTCVc.title = @"BTC钱包";
    [self addChildViewController:BTCVc];
    
    // ETC
    ABCoinViewController *ETCVc = [[ABCoinViewController alloc] init];
    ETCVc.title = @"ETC钱包";
    [self addChildViewController:ETCVc];
}

#pragma mark - setUpTitlesView
- (void)setUpTitlesView {
    
    // 顶部样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *titleScrollViewColor = [UIColor colorWithHexString:@"ffffff"];
        *norColor = [UIColor colorWithHexString:@"999999"];
        *selColor = [UIColor colorWithHexString:@"1c2834"];
        *titleWidth = ABScreenWidth / self.childViewControllers.count;
    }];
    
    // 下标指示器
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        
        *isUnderLineEqualTitleWidth = YES;
        *underLineColor = [UIColor colorWithHexString:@"1c2834"];
    }];
}

- (void)setUpWalletButtons {

    WS(ws);
    UIButton *create = [UIButton buttonWithBackgroundColor:@"01b9db" textColor:@"feffff" text:@"创建钱包" target:self action:@selector(createWallet)];
    [self.view addSubview:create];
    
    [create mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.view.mas_left);
        make.bottom.equalTo(ws.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ABScreenWidth * 0.5, AdaptedHeight(49)));
    }];
    
    UIButton *insert = [UIButton buttonWithBackgroundColor:@"1c2834" textColor:@"feffff" text:@"导入钱包" target:self action:@selector(insertWallet)];
    [self.view addSubview:insert];
    
    [insert mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ABScreenWidth * 0.5, AdaptedHeight(49)));
    }];
}

- (void)back {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createWallet {

    NSLog(@"创建钱包");
}

- (void)insertWallet {
    
    NSLog(@"创建钱包");
}


























@end
