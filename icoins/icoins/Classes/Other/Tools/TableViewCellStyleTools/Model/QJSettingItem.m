//
//  QJSettingItem.m
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "QJSettingItem.h"

@implementation QJSettingItem

#pragma mark - 初始化
- (instancetype)init {

    self.titleFont = [UIFont systemFontOfSize:17];
    self.detialTitleFont = [UIFont systemFontOfSize:15];
    
    return [super init];
}

#pragma mark - 类方法

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title detialTitle:(NSString *)detialTitle {
    
    QJSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.detialTitle = detialTitle;
    
    return item;
}

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title {

    return [self itemWithIcon:icon title:title detialTitle:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title {

    return [self itemWithIcon:nil title:title detialTitle:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title detialTitle:(NSString *)detialTitle {

    return [self itemWithIcon:nil title:title detialTitle:detialTitle];
}

@end
