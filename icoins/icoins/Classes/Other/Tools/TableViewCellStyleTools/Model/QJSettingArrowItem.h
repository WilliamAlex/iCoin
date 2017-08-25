//
//  QJSettingArrowItem.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingItem.h"

@interface QJSettingArrowItem : QJSettingItem

/**点击这一行cell要跳转的目标控制器*/
@property (nonatomic, assign) Class destinationVc;

@end
