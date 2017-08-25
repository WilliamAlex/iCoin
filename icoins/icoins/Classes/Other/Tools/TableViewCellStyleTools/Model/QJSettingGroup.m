//
//  QJSettingGroup.m
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingGroup.h"

@implementation QJSettingGroup

+ (instancetype)groupWithItems:(NSArray *)items {

    QJSettingGroup *group = [[self alloc] init];
    group.items = items;
    return group;
}
@end
