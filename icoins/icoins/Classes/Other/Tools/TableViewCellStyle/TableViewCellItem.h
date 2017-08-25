//
//  TableViewCellItem.h
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellItemBlock)();

@interface TableViewCellItem : NSObject

// 图片
@property (nonatomic, copy) NSString *icon;

// 标题
@property (nonatomic, copy) NSString *title;

// 副标题
@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, assign) Class itemClass;

@property (nonatomic, copy) NSString *timeLabel;

@property (nonatomic, weak) TableViewCellItemBlock itemOperationBlock;

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title;

+ (instancetype)settingItemWithIcon:(NSString *)icon andTitle:(NSString *)title andClass:(Class)itemClass;

+ (instancetype)settingItemWithTitle:(NSString *)title andClass:(Class)itemClass;


+ (instancetype)settingItemWithTitle:(NSString *)title detailText:(NSString *)detailText andClass:(Class)itemClass;

+ (instancetype)settingItemWithTitle:(NSString *)title andDetailText:(NSString *)detailText;

+ (instancetype)settingItemWithTitle:(NSString *)title andTimeLabel:(NSString *)timeLabel;


+ (instancetype)settingItemWithTitle:(NSString *)title;


@end
