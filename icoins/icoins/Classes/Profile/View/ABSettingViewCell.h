//
//  ABSettingViewCell.h
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABSettingViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
@property (weak, nonatomic) IBOutlet UIView *lineView;

// 是否显示底部分割线
@property (nonatomic, assign, getter=isShowBottomLine) BOOL showBottomLine;
@end
