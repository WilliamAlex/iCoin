//
//  TableViewCellGroup.h
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellGroup : NSObject

@property (nonatomic, strong) NSArray *items;

// 组头
@property (nonatomic, copy) NSString *header;

// 组尾
@property (nonatomic, copy) NSString *footer;

// 设置普通的cell样式组
+ (instancetype)setTableViewCellGroupWithItems:(NSArray *)items;

// 设置有组头/组尾的cell样式组
+ (instancetype)setTableViewCellGroupWithItems:(NSArray *)items header:(NSString *)header footer:(NSString *)footer;

@end
