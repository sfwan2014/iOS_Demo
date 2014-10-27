//
//  HorCollectionView.m
//  CustomCollectionVIew
//
//  Created by sfwan on 14-10-13.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HorCollectionView.h"
#import "CollectionViewCell.h"

@implementation HorCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSInteger item = indexPath.item;
//    if (item > 6) {
//        item = item - 7;
//    }
    cell.contentLabel.text = [NSString stringWithFormat:@"%d", item];
    return cell;
}

#pragma mark - collectionView delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kItemWidth, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    //无限循环....
    float targetX = _scrollView.contentOffset.x;
    int numCount = [self numberOfItemsInSection:0];
    float ITEM_WIDTH = kItemWidth;
    CGFloat w = ITEM_WIDTH * (numCount - 3);
//    NSLog(@"%f %f", targetX, w);
    
    if (numCount>=3)
    {
        if (targetX < ITEM_WIDTH) {
//            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
        }// 680  880 700(7 8 9)
        else if (targetX > ITEM_WIDTH *(numCount))
        {
//            CGFloat yy = targetX-ITEM_WIDTH *(numCount);
//            NSLog(@"yy=%f", yy);
//            [_scrollView setContentOffset:CGPointMake( yy, 0)];
        }
    }
    
}


@end
