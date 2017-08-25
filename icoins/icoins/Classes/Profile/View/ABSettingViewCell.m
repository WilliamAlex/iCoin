//
//  ABSettingViewCell.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABSettingViewCell.h"

@implementation ABSettingViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.title.font = AdaptedFontSize(15);
    self.title.textColor = [UIColor colorWithHexString:@"999999"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setShowBottomLine:(BOOL)showBottomLine {

    _showBottomLine = showBottomLine;
     self.lineView.hidden = _showBottomLine ? NO : YES;      //关闭隐藏分割线
}
- (IBAction)sw:(id)sender {
    
}



@end
