//
//  ABProfileViewCell.h
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableViewCellDelegate <NSObject>

@optional
- (void)settingCellChangeSwitchItem:(TableViewCellItemSwitch *)item;

@end

@interface ABProfileViewCell : UITableViewCell


@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UISwitch *sw;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, weak) id <TableViewCellDelegate>delegate;

// 模型
@property (nonatomic, strong) TableViewCellItem *item;

+ (instancetype)settingItemCell:(UITableView *)tableView;

// 是否显示底部分割线
@property (nonatomic, assign, getter=isShowBottomLine) BOOL showBottomLine;


@end
