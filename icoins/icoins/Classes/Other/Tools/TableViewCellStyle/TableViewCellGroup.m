//
//  TableViewCellGroup.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellGroup.h"

@implementation TableViewCellGroup

+ (instancetype)setTableViewCellGroupWithItems:(NSArray *)items
{

    TableViewCellGroup *group = [[TableViewCellGroup alloc] init];
    group.items = items;
    return group;
}

+ (instancetype)setTableViewCellGroupWithItems:(NSArray *)items header:(NSString *)header footer:(NSString *)footer
{
    TableViewCellGroup *group = [self setTableViewCellGroupWithItems:items];
    group.header = header;
    group.footer = footer;
    
    return group;
}
@end
