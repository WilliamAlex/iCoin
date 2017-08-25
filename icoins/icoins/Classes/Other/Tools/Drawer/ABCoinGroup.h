//
//  ABCoinGroup.h
//  icoins
//
//  Created by Alex Williams on 2017/8/19.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <Foundation/Foundation.h>

// 币类分组
@interface ABCoinGroup : NSObject

// 联系人数据
@property (nonatomic, strong) NSMutableArray *items;

// 每个组中有多少项
@property (nonatomic, assign, readonly) NSUInteger size;

// 是否折叠
@property (nonatomic, assign, getter=isFolded) BOOL folded;

// 初始化方法
- (instancetype)initWithItem:(NSMutableArray *)item;
    
    
@end
