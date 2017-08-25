//
//  ABTitleCollectionViewFlowLayout.m
//  icoins
//
//  Created by williamalex on 2017/8/22.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABTitleCollectionViewFlowLayout.h"

@implementation ABTitleCollectionViewFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    if (self.collectionView.bounds.size.height) {
        
        self.itemSize = self.collectionView.bounds.size;
    }
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
