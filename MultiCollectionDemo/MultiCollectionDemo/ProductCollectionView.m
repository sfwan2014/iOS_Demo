//
//  ProductCollectionView.m
//  MultiCollectionDemo
//
//  Created by sfwan on 14-10-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ProductCollectionView.h"
#import "ProductCollectionViewCell.h"

@implementation ProductCollectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"c_ell"];
    
    UINib *nib = [UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:@"cellId"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    } else if (section == 1) {
        return 1;
    } else {
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.type = indexPath.section;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"c_ell" forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
//    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = (UILabel *)[view viewWithTag:2013];
    UIImageView *imgView = (UIImageView *)[view viewWithTag:2014];
    if (label == nil) {
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 30, 27)];
        imgView.tag = 2014;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x + imgView.frame.size.width, imgView.frame.origin.y, 150, 27)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 2013;
        [view addSubview:label];
        [view addSubview:imgView];
    }
    
    if (indexPath.section == 1) {
        label.text = @"返点最高";
        imgView.image = [UIImage imageNamed:@"productCenter_back_dot"];
    } else if (indexPath.section == 2) {
        label.text = @"交易最多";
        imgView.image = [UIImage imageNamed:@"productCenter_trade_most"];
    }
    
    return view;
}

#pragma mark - delegate
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return 20;
    }
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



// 组的脚视图size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section

{
    return CGSizeZero;
}
// 组的头视图size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(320, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return CGSizeMake((collectionView.frame.size.width-2)/3.0, 50);
    }else if (indexPath.section == 1) {
        return CGSizeMake(collectionView.frame.size.width, 120);
    }
    
    return CGSizeMake(80, 85);
}

@end
