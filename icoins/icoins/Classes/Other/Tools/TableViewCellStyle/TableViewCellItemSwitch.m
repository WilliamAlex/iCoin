//
//  TableViewCellItemSwitch.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/11/7.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "TableViewCellItemSwitch.h"
#define WGDefaults [NSUserDefaults standardUserDefaults]

@implementation TableViewCellItemSwitch

#warning 在改变开关状态 setter方法中保存开关状态到偏好设置，在创建的时候从偏好设置加载
//在setter方法中保存开关状态到偏好设置
- (void)setOn:(BOOL)on
{
    _on = on;
    
    [WGDefaults setBool:on forKey:self.title];
    
    //立刻保存
    [WGDefaults synchronize];
    
    if (self.didChangeHandler) {
        self.didChangeHandler(_on);
    }
    
    //    WGLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
}

#warning 因为创建模型最终都一定会调用setTitle方法，所以选择在该方法中加载开关状态
//重写setTitle方法 从偏好设置加载开关状态
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.on = [WGDefaults boolForKey:title];
}


@end
