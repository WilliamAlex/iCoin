//
//  TableViewCellItemArrow.h
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItem.h"

@interface TableViewCellItemArrow : TableViewCellItem

@property (nonatomic, copy) NSString *accessLabel;

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title andLabel:(NSString *)label;

@end
