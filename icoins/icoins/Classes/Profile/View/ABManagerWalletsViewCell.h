//
//  ABManagerWalletsViewCell.h
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ABCoinType) {

    kABCoinOfBTCType,   // 比特币
    kABCoinOfETHType,   // 以太币
};

@interface ABManagerWalletsViewCell : UITableViewCell

// 钱包名称
@property (weak, nonatomic) IBOutlet UILabel *walletName;

// 钱包地址
@property (weak, nonatomic) IBOutlet UILabel *walletAddress;

// 比特币价格
@property (weak, nonatomic) IBOutlet UILabel *coinPrice;

// 编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *editted;

@property (assign, nonatomic) ABCoinType type;

@end
