//
//  QJSettingGroup.h
//  TableViewCellStyleTool
//
//  Created by Alex on 2017/4/20.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJSettingGroup : NSObject

/**这一组的头部标题*/
@property (nonatomic, copy) NSString *headerTitle;

/**这一组的尾部标题*/
@property (nonatomic, copy) NSString *footTitle;

/**这一组的行模型数组*/
@property (nonatomic, strong) NSArray *items;

/**工厂方法*/
+ (instancetype)groupWithItems:(NSArray *)items;

@end
