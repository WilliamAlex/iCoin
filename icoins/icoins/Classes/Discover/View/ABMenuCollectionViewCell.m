//
//  ABMenuCollectionViewCell.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABMenuCollectionViewCell.h"

@implementation ABMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.menuLabel.font = AdaptedFontSize(14);
    self.menuLabel.textColor = [UIColor colorWithHexString:@"999999"];
}

@end
