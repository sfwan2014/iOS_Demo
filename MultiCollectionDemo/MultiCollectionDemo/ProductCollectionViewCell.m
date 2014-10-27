//
//  ProductCollectionViewCell.m
//  MultiCollectionDemo
//
//  Created by sfwan on 14-10-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "ProductDisplayView.h"
#import "ProductMenuView.h"
#import "SubCollectionView.h"

@implementation ProductCollectionViewCell
{
    ProductDisplayView *displayView;
    ProductMenuView *menuView;
    SubCollectionView *subCollectionView;
}

- (void)awakeFromNib {
    displayView = [ProductDisplayView loadFromNib];
    menuView = [ProductMenuView loadFromNib];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    subCollectionView  = [[SubCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
}

-(void)setType:(kCollectionCellType)type
{
    _type = type;
    
    [self resetSubView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    menuView.frame = self.bounds;
    displayView.frame = self.bounds;
    subCollectionView.frame = self.bounds;
}

-(void)resetSubView
{
    [displayView removeFromSuperview];
    [menuView removeFromSuperview];
    [subCollectionView removeFromSuperview];
    switch (_type) {
        case kCollectionCellTypeMenu:
        {
            if (menuView.superview == nil) {
                [self.contentView addSubview:menuView];
            }
        }
            break;
        case kCollectionCellTypeBackDot:
        {
            [self.contentView addSubview:subCollectionView];
        }
            break;
        case kCollectionCellTypeTradeMost:
        {
            [self.contentView addSubview:displayView];
        }
            break;
            
        default:
            break;
    }
}

@end
