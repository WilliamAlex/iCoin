//
//  QJSettingTableViewController.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJSettingTableViewCell.h"


@interface QJSettingTableViewController : UITableViewController

/**
 *  数组总数
 */
@property (nonatomic, strong) NSMutableArray *groups;

// 将行模型数组添加到这一组
- (QJSettingGroup *)addGroupWithItems:(NSArray *)items;
@end
