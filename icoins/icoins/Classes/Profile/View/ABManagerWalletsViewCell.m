//
//  ABManagerWalletsViewCell.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABManagerWalletsViewCell.h"

@implementation ABManagerWalletsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.walletName.font = AdaptedFontSize(15);
    self.walletName.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.walletAddress.font = AdaptedFontSize(12);
    self.walletAddress.textColor = [UIColor colorWithHexString:@"999999"];
    
    switch (self.type) {
            
        case kABCoinOfBTCType:
        {
            self.coinPrice.font = AdaptedFontSize(18);
            self.coinPrice.textColor = [UIColor colorWithHexString:@"ab8c2c"];
        }
            break;
            
        case kABCoinOfETHType:
        {
            self.coinPrice.font = AdaptedFontSize(18);
            self.coinPrice.textColor = [UIColor colorWithHexString:@"01b9db"];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)editted:(id)sender {
    
    NSLog(@"点击了编辑按钮");
}



@end
