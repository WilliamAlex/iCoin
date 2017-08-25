//
//  ABWalletCoinView.m
//  icoins
//
//  Created by williamalex on 2017/8/18.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABWalletCoinView.h"

@implementation ABWalletCoinView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        WS(ws);
        
        // 币种图片
        UIImageView *coinImageView = [[UIImageView alloc] init];
        coinImageView.image = [UIImage imageNamed:@"currency-1"];
        [self addSubview:coinImageView];
        self.coinImageView = coinImageView;
        
        [coinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(ws.mas_centerY);
            make.left.equalTo(ws.mas_left).offset(AdaptedWidth(25));
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        // 币种名称
        UILabel *coinLabel = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:15 textAlignment:NSTextAlignmentLeft text:@"BTC"];
        [self addSubview:coinLabel];
        self.coin = coinLabel;
        [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(coinImageView.mas_centerY);
            make.left.equalTo(coinImageView.mas_right).offset(AdaptedWidth(margin));
            
        }];
        
        // 数量
        UILabel *amount = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:15 textAlignment:NSTextAlignmentRight text:@"150"];
        [self addSubview:amount];
        [amount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(coinImageView.mas_centerY);
            make.right.equalTo(ws.mas_right).offset(AdaptedWidth(-15));
        }];
        
        // 价格
        UILabel *price = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:13 textAlignment:NSTextAlignmentRight text:@"≈10.0 ¥"];
        [self addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(amount.mas_right);
            make.top.equalTo(amount.mas_bottom).offset(AdaptedWidth(5));
        }];
    }
    
    return self;
}

@end

























