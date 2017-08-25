//
//  QJSettingSwitchItem.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingItem.h"

@interface QJSettingSwitchItem : QJSettingItem


/**这一行cell的右侧视图开关状态*/
@property (nonatomic, assign, getter=isOn) BOOL on;

@end
