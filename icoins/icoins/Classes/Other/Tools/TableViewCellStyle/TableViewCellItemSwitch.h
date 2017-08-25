//
//  TableViewCellItemSwitch.h
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItem.h"

typedef void(^changeHandler)(BOOL isOn);
@interface TableViewCellItemSwitch : TableViewCellItem

// 是否开启
@property (nonatomic, assign, getter=isOn) BOOL on;

@property(nonatomic, copy) changeHandler didChangeHandler;
@end
