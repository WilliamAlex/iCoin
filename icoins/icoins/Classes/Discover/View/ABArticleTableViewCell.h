//
//  ABArticleTableViewCell.h
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABArticleTableViewCell : UITableViewCell

// 爱币钱包
@property (weak, nonatomic) IBOutlet UILabel *walletLabel;

// 日期
@property (weak, nonatomic) IBOutlet UILabel *date;

// 文章标题
@property (weak, nonatomic) IBOutlet UILabel *title;

// 图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@end
