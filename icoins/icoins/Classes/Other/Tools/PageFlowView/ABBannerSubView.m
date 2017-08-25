//
//  ABBannerSubView.m
//  icoins
//
//  Created by williamalex on 2017/8/23.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABBannerSubView.h"

@implementation ABBannerSubView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        
        // 添加点击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
        
        [self setUpAddressInfos];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

- (void)setUpAddressInfos {

    WS(ws);
    
    
    // 币的的地址
    UILabel *address = [UILabel labelWithFrame:CGRectZero textColor:@"ffffff" backgroundColor:nil textFont:15 textAlignment:NSTextAlignmentLeft text:@"0x66dsd6ffd7777f556hh78884ssfsf6666s6s6fs"];
    address.numberOfLines = 0;
    [self addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.mas_left).offset(AdaptedWidth(15));
        make.right.equalTo(ws.mas_right).offset(AdaptedWidth(-15));
        make.centerY.equalTo(ws.mas_centerY);
    }];
}


@end











