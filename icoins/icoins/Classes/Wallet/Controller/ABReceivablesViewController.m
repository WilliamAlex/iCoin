//
//  ABReceivablesViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABReceivablesViewController.h"

@interface ABReceivablesViewController ()

@end

@implementation ABReceivablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpContentView];
}

- (void)setUpContentView {

    WS(ws);
    UILabel *coinPrice = [UILabel labelWithFrame:CGRectZero textColor:@"ab8c2c" backgroundColor:nil textFont:45 textAlignment:NSTextAlignmentCenter text:@"150.00฿"];
    [self.view addSubview:coinPrice];
    [coinPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(ws.view.mas_centerX);
        make.top.equalTo(ws.view.mas_top).offset(AdaptedHeight(40));
    }];
    
    UILabel *RNB = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:14 textAlignment:NSTextAlignmentCenter text:@"≈25.00¥"];
    [self.view addSubview:RNB];
    [RNB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(coinPrice.mas_centerX);
        make.top.equalTo(coinPrice.mas_bottom).offset(AdaptedHeight(10));
    }];
    
    UILabel *CrowdLabel = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:14 textAlignment:NSTextAlignmentCenter text:@"手机众筹网"];
    [self.view addSubview:CrowdLabel];
    [CrowdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(coinPrice.mas_centerX);
        make.top.equalTo(RNB.mas_bottom).offset(AdaptedHeight(10));
    }];
    
    // 比特币地址
    UILabel *addressLabel = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:14 textAlignment:NSTextAlignmentCenter text:@"3CfzoJjtzyh5UuZn9xHbcKLXwcq6mqXb6p"];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(coinPrice.mas_centerX);
        make.top.equalTo(CrowdLabel.mas_bottom).offset(AdaptedHeight(20));
    }];
    
    // 地址的二维码
    UIImageView *qrImageView = [[UIImageView alloc] init];
    qrImageView.image = [UIImage imageNamed:@"address"];
    [self.view addSubview:qrImageView];
    
    [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(addressLabel.mas_bottom).offset(AdaptedHeight(15));
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(213), AdaptedHeight(213)));
        make.centerX.equalTo(ws.view.mas_centerX);
    }];
    
    UIButton *copyBtn = [UIButton buttonWithBackgroundColor:@"01b9db" textColor:@"ffffff" text:@"复制收款地址" target:self action:@selector(copyAddress)];
    [self.view addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(qrImageView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(212), AdaptedHeight(44)));
        make.top.equalTo(qrImageView.mas_bottom).offset(AdaptedHeight(15));
    }];
}

- (void)copyAddress {

    NSLog(@"复制收款地址");
}



@end

































