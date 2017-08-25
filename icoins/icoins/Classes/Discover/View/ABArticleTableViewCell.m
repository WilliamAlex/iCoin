//
//  ABArticleTableViewCell.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABArticleTableViewCell.h"

@implementation ABArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.title.font = AdaptedFontSize(14);
    self.title.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.walletLabel.font = AdaptedFontSize(12);
    self.walletLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    self.date.textColor = [UIColor colorWithHexString:@"999999"];
    self.date.font = AdaptedFontSize(12);
}

@end
