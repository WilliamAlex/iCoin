//
//  TableViewCellItem.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItem.h"

@implementation TableViewCellItem

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title
{
    TableViewCellItem *item = [[self alloc] init];
    
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title andClass:(Class)itemClass
{
    TableViewCellItem *item = [self settingItemWithIcon:icon andTitle:title];
    
    item.itemClass = itemClass;
    
    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title andClass:(Class)itemClass
{
    return [self settingItemWithIcon:nil andTitle:title andClass:itemClass];
}

+ (instancetype)settingItemWithTitle:(NSString *)title andDetailText:(NSString *)detailText
{
    TableViewCellItem *item = [self settingItemWithIcon:nil andTitle:title];
    
    item.detailText = detailText;
    
    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title detailText:(NSString *)detailText andClass:(Class)itemClass {

    TableViewCellItem *item = [self settingItemWithTitle:title andDetailText:detailText];
    item.itemClass = itemClass;
    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title andTimeLabel:(NSString *)timeLabel
{
    TableViewCellItem *item = [self settingItemWithIcon:nil andTitle:title];

    item.timeLabel = timeLabel;

    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title
{
    return [self settingItemWithIcon:nil andTitle:title];
}

@end
