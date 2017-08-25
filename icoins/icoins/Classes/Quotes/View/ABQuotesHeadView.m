//
//  ABQuotesHeadView.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABQuotesHeadView.h"

@implementation ABQuotesHeadView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *headView = [[UIView alloc] init];
        headView.frame = CGRectMake(0, 0, ABScreenWidth, AdaptedHeight(50));
        [self addSubview:headView];
        
        NSArray *titles = @[@"资产名称", @"最新价", @"涨跌幅"];
        CGFloat width = ABScreenWidth / titles.count;
        CGFloat height = 50;
        
        for (int i = 0 ; i < titles.count; i++) {
            
            UILabel *label = [[UILabel alloc] init];
            
            label.ab_width = width;
            label.ab_height = height;
            label.ab_x = i * width;
            label.text = titles[i];
            label.textColor = [UIColor colorWithHexString:@"ffffff"];
            label.alpha = 0.45;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = AdaptedFontSize(15);
            [headView addSubview:label];
        }
        
        UIView *sepView = [[UIView alloc] init];
        sepView.backgroundColor = [UIColor colorWithHexString:@"19232e"];
        [headView addSubview:sepView];
        
        [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.left.width.mas_equalTo(headView);
            make.height.mas_equalTo(@(AdaptedHeight(0.5)));
        }];
    }
    
    return self;
}

@end
