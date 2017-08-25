//
//  QJSettingTableViewCell.m
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingTableViewCell.h"

@implementation QJSettingTableViewCell

// 快速创建一个cell
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle {

    NSString *ID = @"QJSettingTableViewCell";
    QJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[QJSettingTableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    
    return cell;
}

// 快速创建一个cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {

    return [self cellWithTableView:tableView cellStyle:UITableViewCellStyleValue1];
}

// 通过模型数组赋值
- (void)setItem:(QJSettingItem *)item {

    _item = item;
    
    // 设置数据
    
    // 标题
    self.textLabel.text = item.title;
    self.textLabel.font = item.titleFont;
    
    // 副标题
    self.detailTextLabel.text = item.detialTitle;
    self.detailTextLabel.font = item.detialTitleFont;
    
    // 设置左侧视图
    self.imageView.image = item.icon;
    
    // 设置右侧视图
    [self setUpRightView];
}

// 设置右侧视图
- (void)setUpRightView {

    if ([self.item isKindOfClass:[QJSettingArrowItem class]]) {
        
        // 右侧是箭头
        UIImage *arrowImg = [UIImage imageWithContentsOfFile:QJPathResoce(@"arrow_right")];
        self.accessoryView = [[UIImageView alloc] initWithImage:arrowImg];
    } else if ([self.item isKindOfClass:[QJSettingSwitchItem class]]) {
    
        // 右侧是UISwitch视图
        QJSettingSwitchItem *swItem = (QJSettingSwitchItem *)self.item;
        UISwitch *sw = [[UISwitch alloc] init];
        sw.on = swItem.isOn;
        
        self.accessoryView = sw;
    } else {
    
    self.accessoryView = nil;
    }
}


@end







































