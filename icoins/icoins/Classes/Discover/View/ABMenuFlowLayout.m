//
//  ABMenuFlowLayout.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//
// 当菜单可以有分页的时候, 是可以滚动的
#import "ABMenuFlowLayout.h"

@implementation ABMenuFlowLayout
{
    NSMutableArray *_attributeArray;
    int _itemCount;
}

- (void)prepareLayout {
    
    _attributeArray = [[NSMutableArray alloc] init];
    [super prepareLayout];
    
    // 九宫格格式, 可以设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 每个item宽和高
    CGFloat WIDTH = (ABScreenWidth - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (_arrange-1))/_arrange;
    CGFloat HEIGHT = (self.collectionView.bounds.size.height - self.sectionInset.top - self.sectionInset.bottom - self.minimumLineSpacing*(_rank-1))/_rank;
    [_attributeArray removeAllObjects];
    
    // 获取item的个数
    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
    
    // 布局item
    for (int i=0; i<_itemCount; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
        //判断是第几页(从0开始)
        NSInteger page = i/(_rank*_arrange);
        //判断是第几列
        NSInteger line = i%_arrange;
        //判断是第几行
        NSInteger row = i/_arrange;
        //为了换页排列
        NSInteger locationY = row%2;
        
        //计算每个item的位置
        CGFloat x = self.sectionInset.left + (WIDTH+self.minimumInteritemSpacing)*line + page*ABScreenWidth;
        CGFloat y = self.sectionInset.top+(HEIGHT+self.minimumLineSpacing)*locationY;
        attris.frame = CGRectMake(x, y, WIDTH, HEIGHT);
        [_attributeArray addObject:attris];
    }
}

//设置滑动区域
- (CGSize)collectionViewContentSize {
    
    //总页数
    NSInteger pages = _itemCount/(_rank*_arrange) + ((_itemCount%(_arrange*_rank)==0)?0:1);
    return CGSizeMake(self.collectionView.bounds.size.width*pages, self.collectionView.bounds.size.height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return _attributeArray;
}





@end
