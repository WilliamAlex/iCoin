//
//  TableViewCellItemLabel.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItemLabel.h"

@implementation TableViewCellItemLabel

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title andLabel:(NSString *)label
{
    TableViewCellItemLabel *item = [self settingItemWithIcon:icon andTitle:title];
    item.label = label;
    return item;
}
@end
