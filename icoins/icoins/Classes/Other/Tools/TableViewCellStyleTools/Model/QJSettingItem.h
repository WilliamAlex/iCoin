//
//  QJSettingItem.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QJSettingItem : NSObject

/**
 *  这一行的标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  这一行标题的大小, 默认17
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  这一行的子标题
 */
@property (nonatomic, copy) NSString *detialTitle;

/**
 *  这一行子标标题的大小, 默认15
 */
@property (nonatomic, strong) UIFont *detialTitleFont;

/**
 *  这一行的图标
 */
@property (nonatomic, strong) UIImage *icon;

/**
 *  点击这一行cell要做的操作
 */
@property (nonatomic, copy) void(^operationBlock)(NSIndexPath *indexPath);

/**
 *  快速创建一个有图标,标题,子标题的行模型
 *
 *  @param icon     图标
 *  @param title    标题
 *  @param detialTitle 子标题
 *
 *  @return 一个创建好的模型,有图标,标题,子标题
 */
+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title detialTitle:(NSString *)detialTitle;

/**
 *  快速创建一个有图标,标题的行模型
 *
 *  @param icon  图标
 *  @param title 标题
 *
 *  @return 一个创建好的模型,有图标,标题
 */
+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title;

/**
 *  快速创建一个有标题,子标题的行模型
 *
 *  @param title    标题
 *  @param detialTitle 子标题
 *
 *  @return 一个创建好的模型,标题,子标题
 */
+ (instancetype)itemWithTitle:(NSString *)title detialTitle:(NSString *)detialTitle;

/**
 *  快速创建一个有标题的行模型
 *
 *  @param title 标题
 *
 *  @return 一个创建好的模型,有标题
 */
+ (instancetype)itemWithTitle:(NSString *)title;



@end
