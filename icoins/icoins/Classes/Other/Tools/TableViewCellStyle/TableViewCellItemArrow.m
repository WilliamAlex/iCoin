//
//  TableViewCellItemArrow.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItemArrow.h"

@implementation TableViewCellItemArrow

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title andLabel:(NSString *)label
{
    TableViewCellItemArrow *item = [self settingItemWithIcon:icon andTitle:title];
    item.accessLabel = label;
    return item;

}
@end
