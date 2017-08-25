//
//  ABMenuView.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABMenuView.h"
#import "ABMenuFlowLayout.h"
#import "ABMenuCollectionViewCell.h"




@implementation ABMenuView
{
    ABMenuFlowLayout *_layout;
    UICollectionView *_collect;
    NSInteger _arrange;
    NSInteger _rank;
}

- (instancetype)initWithFrame:(CGRect)frame Arrange:(NSInteger)arrange Rank:(NSInteger)rank {
    
    self = [super initWithFrame:frame];
    if (self) {
        _arrange = arrange; //列数
        _rank = rank;       //行数
        [self creatUI];
    }
    return self;
}

// 搭建UI界面
- (void)creatUI {

    _layout = [[ABMenuFlowLayout alloc] init];
    _layout.rank = _rank;
    _layout.arrange = _arrange;
    
    _collect = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    _collect.dataSource = self;
    _collect.delegate = self;
    _collect.backgroundColor = [UIColor whiteColor];
    _collect.showsVerticalScrollIndicator = NO;
    _collect.showsHorizontalScrollIndicator = NO;
    [_collect registerNib:[UINib nibWithNibName:NSStringFromClass([ABMenuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MENUCELL"];
    [self addSubview:_collect];
}

// 布局
- (void)layoutSubviews {

    [super layoutSubviews];
    _layout.minimumInteritemSpacing = self.interitemSpacing;
    _layout.minimumLineSpacing = self.lineSpacing;
    _layout.sectionInset = self.viewEdgeInsets;
    _collect.backgroundColor = self.backgroundColor;
}

#pragma mark - collectView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ABMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MENUCELL" forIndexPath:indexPath];
    cell.menuLabel.text = _titles[indexPath.item];
    cell.menuImageView.image = [UIImage imageNamed:_icons[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_delegate respondsToSelector:@selector(menuViewDidSelectedItemWithIndex:)]) {
        
        [_delegate menuViewDidSelectedItemWithIndex:indexPath.item];
    }
}



@end
