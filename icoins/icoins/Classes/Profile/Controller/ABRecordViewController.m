//
//  ABRecordViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABRecordViewController.h"
#import "ABRecordTransactionViewController.h"


@interface ABRecordViewController ()

@end

@implementation ABRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpInitCurrentViewController];
    
    // 添加子控制器
    [self addChildViewControllers];
    
    // 顶部标签(一定是在添加控制器之后)
    [self setUpTitlesView];
}

- (void)setUpInitCurrentViewController {

    // title
    self.navigationItem.title = @"";
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"交易记录"];
    self.navigationItem.titleView = titleLabel;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
}

#pragma mark - addChildViewControllers
- (void)addChildViewControllers {
    
    // 全部
    ABRecordTransactionViewController *allVc = [[ABRecordTransactionViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // BTC钱包
    ABRecordTransactionViewController *BTCVc = [[ABRecordTransactionViewController alloc] init];
    BTCVc.title = @"BTC钱包";
    [self addChildViewController:BTCVc];
    
    // ETH钱包
    ABRecordTransactionViewController *ETHVc = [[ABRecordTransactionViewController alloc] init];
    ETHVc.title = @"ETH钱包";

    [self addChildViewController:ETHVc];
}

#pragma mark - setUpTitlesView
- (void)setUpTitlesView {
    
    // 顶部样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *titleScrollViewColor = [UIColor colorWithHexString:@"ffffff"];
        *norColor = [UIColor colorWithHexString:@"666666"];
        *selColor = [UIColor colorWithHexString:@"1c2834"];
        *titleWidth = ABScreenWidth / self.childViewControllers.count;
    }];
    
    // 下标指示器
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        
        *isUnderLineEqualTitleWidth = YES;
        *underLineColor = [UIColor colorWithHexString:@"1c2834"];
    }];
}

@end
