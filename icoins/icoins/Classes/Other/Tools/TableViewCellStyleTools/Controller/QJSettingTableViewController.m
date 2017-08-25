//
//  QJSettingTableViewController.m
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingTableViewController.h"

@interface QJSettingTableViewController ()

@end

@implementation QJSettingTableViewController

#pragma mark - 懒加载
- (NSMutableArray *)groups {

    if (!_groups) {
        
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 将模型添加到数组中
- (QJSettingGroup *)addGroupWithItems:(NSArray *)items {

    // 安全校验
    if (items.count == 0) return nil;
    
    // 创建模型
    QJSettingGroup *group = [QJSettingGroup groupWithItems:items];
    
    // 将模型数组添加到数组中
    [self.groups addObject:group];
    
    return group;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // 取出组模型数组
    QJSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    QJSettingTableViewCell *cell = [QJSettingTableViewCell cellWithTableView:tableView];
    
    // 从总数组中取出组模型数组
    QJSettingGroup *group = self.groups[indexPath.section];
    
    // 从组模型中取出行模型
    QJSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 点击cell选中消失效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 从总数组中取出组模型数组
    QJSettingGroup *group = self.groups[indexPath.section];
    
    // 从行模型数组中取出行模型
    QJSettingItem *item = group.items[indexPath.row];
    
    if (item.operationBlock) {
        item.operationBlock(indexPath);
    }else if ([item isKindOfClass:[QJSettingArrowItem class]]) {
        
        // 只有剪头模型才具备跳转功能
        QJSettingArrowItem *arrowItem = (QJSettingArrowItem *)item;
        
        if (arrowItem.destinationVc) {
            // 有目标控制器
            // 拿到目标控制器类名 创建目标控制器
            UIViewController *vc = [[arrowItem.destinationVc alloc] init];
            vc.title = arrowItem.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 取出组模型
    QJSettingGroup *group =  self.groups[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:   (NSInteger)section{
    // 取出组模型
    QJSettingGroup *group =  self.groups[section];
    return group.footTitle;
}



@end

































