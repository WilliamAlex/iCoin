//
//  QJSettingTableViewCell.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJSettingGroup.h"
#import "QJSettingItem.h"
#import "QJSettingArrowItem.h"
#import "QJSettingSwitchItem.h"

@interface QJSettingTableViewCell : UITableViewCell

/**快速创建tableViewCell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 * 快速创建tableViewCell
 * cellStyle  cell的样式
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle;

/**cell的模型*/
@property (nonatomic, strong) QJSettingItem *item;
@end
