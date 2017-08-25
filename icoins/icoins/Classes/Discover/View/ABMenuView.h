//
//  ABMenuView.h
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABMenuView;

@protocol ABMenuViewDelegate <NSObject>


/**
 点击触发事件
 
 @param index 对应的索引
 */
- (void)menuViewDidSelectedItemWithIndex:(NSInteger)index;

@end


@interface ABMenuView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

/**collectionView周边的间距*/
@property (nonatomic, assign) UIEdgeInsets viewEdgeInsets;

/**列间距*/
@property (nonatomic, assign) CGFloat interitemSpacing;

/**行间距*/
@property (nonatomic, assign) CGFloat lineSpacing;

/**标题*/
@property (nonatomic, strong) NSArray *titles;

/**图片*/
@property (nonatomic, strong) NSArray *icons;

@property (nonatomic, weak) id<ABMenuViewDelegate>delegate;


/**
 九宫格布局
 
 @param frame frame
 @param arrange 列数
 @param rank 行数
 @return 返回九宫格布局
 */
- (instancetype)initWithFrame:(CGRect)frame Arrange:(NSInteger)arrange Rank:(NSInteger)rank;
@end
