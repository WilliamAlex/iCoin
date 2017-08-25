//
//  ABCoinGroup.m
//  icoins
//
//  Created by Alex Williams on 2017/8/19.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABCoinGroup.h"

@implementation ABCoinGroup

- (instancetype)initWithItem:(NSMutableArray *)item {

    self = [super init];
    if (self) {
        
        self.folded = YES;
        _items = item;
    }
    
    return self;
}

// 每组有多少item
- (NSUInteger)size {

    return  _items.count;
}
    
@end
