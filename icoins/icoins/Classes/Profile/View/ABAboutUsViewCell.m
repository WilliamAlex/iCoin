//
//  ABAboutUsViewCell.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABAboutUsViewCell.h"

@implementation ABAboutUsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.title.textColor = [UIColor colorWithHexString:@"333333"];
    self.title.font = AdaptedFontSize(15);
    self.detialTitle.font = AdaptedFontSize(12);
    self.detialTitle.textColor = [UIColor colorWithHexString:@"999999"];
}

@end
