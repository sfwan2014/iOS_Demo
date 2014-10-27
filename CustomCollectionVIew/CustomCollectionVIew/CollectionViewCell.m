//
//  CollectionViewCell.m
//  CustomCollectionVIew
//
//  Created by sfwan on 14-10-13.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:190 green:190 blue:190 alpha:0.6];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_contentLabel];
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}
@end
