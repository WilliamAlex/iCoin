//
//  ABQuotesViewCell.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABQuotesViewCell.h"

@implementation ABQuotesViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // cell的样式
       [self setUpCellStyle];
    }
    return self;
}

- (void)setUpCellStyle {

    // 设置cell的高亮效果为none
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"121921"];
    
    
    WS(ws);
    
    // 爱币网
    UILabel *aibiLabel = [UILabel labelWithFrame:CGRectZero textColor:@"617791" backgroundColor:nil textFont:18 textAlignment:NSTextAlignmentLeft text:@"爱币网"];
    [self.contentView addSubview:aibiLabel];
    [aibiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws.mas_top).offset(AdaptedHeight(20));
        make.left.equalTo(ws.mas_left).offset(AdaptedWidth(35));
    }];
    
    // 币种
    UILabel *coinLabel = [UILabel labelWithFrame:CGRectZero textColor:@"ffffff" backgroundColor:nil textFont:20 textAlignment:NSTextAlignmentLeft text:@"BTC"];
    coinLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:20];
    [self.contentView addSubview:coinLabel];
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(aibiLabel.mas_centerX);
        make.top.equalTo(aibiLabel.mas_bottom).offset(AdaptedHeight(5));
    }];
    
    // 美元价格
    UILabel *USD = [UILabel labelWithFrame:CGRectZero textColor:@"617791" backgroundColor:nil textFont:18 textAlignment:NSTextAlignmentCenter text:@"$292.95"];
    [self.contentView addSubview:USD];
    [USD mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(aibiLabel.mas_centerY);
        make.centerX.equalTo(ws.contentView.mas_centerX);
    }];
    
    // 人民币价格
    UILabel *RMB = [UILabel labelWithFrame:CGRectZero textColor:@"ffffff" backgroundColor:nil textFont:20 textAlignment:NSTextAlignmentCenter text:@"¥29973.26"];
    [self.contentView addSubview:RMB];
    [RMB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(coinLabel.mas_centerY);
        make.centerX.equalTo(USD.mas_centerX);
    }];
    
    // 涨幅按钮
    UIButton *PercentButton = [UIButton buttonWithBackgroundColor:@"f5372d" textColor:@"ffffff" text:@"+64.48%" target:self action:@selector(PercentButtonOnClick:)];
    [self.contentView addSubview:PercentButton];
    [PercentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(ws.contentView.mas_centerY);
        make.right.equalTo(ws.contentView.mas_right).offset(AdaptedWidth(-15));
    }];
    
    // 分割线
    UIView *sepView = [[UIView alloc] init];
    sepView.backgroundColor = [UIColor colorWithHexString:@"19232e"];
    [self.contentView addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.contentView.mas_left);
        make.bottom.equalTo(ws.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ABScreenWidth, AdaptedHeight(0.5)));
    }];
}

- (void)PercentButtonOnClick:(UIButton *)button {

    NSLog(@"涨了");
}

@end








