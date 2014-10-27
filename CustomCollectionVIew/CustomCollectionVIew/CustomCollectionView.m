//
//  CustomCollectionView.m
//  CustomCollectionVIew
//
//  Created by sfwan on 14-10-13.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CollectionViewCell.h"


@implementation CustomCollectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    [((UICollectionViewFlowLayout *)self.collectionViewLayout) setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    return cell;
}

#pragma mark - collectionView delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(106, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
//{
//    //无限循环....
//    float targetX = _scrollView.contentOffset.x;
//    int numCount = [self numberOfItemsInSection:0];
//    float ITEM_WIDTH = _scrollView.frame.size.width;
//    
//    if (numCount>=3)
//    {
//        if (targetX < ITEM_WIDTH/2) {
//            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
//        }
//        else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount)
//        {
//            [_scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
//        }
//    }
//    
//}

@end
