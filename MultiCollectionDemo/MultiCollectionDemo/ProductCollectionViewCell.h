//
//  ProductCollectionViewCell.h
//  MultiCollectionDemo
//
//  Created by sfwan on 14-10-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kCollectionCellTypeMenu,
    kCollectionCellTypeBackDot,
    kCollectionCellTypeTradeMost,
} kCollectionCellType;

@interface ProductCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic, assign) kCollectionCellType type;
@end
