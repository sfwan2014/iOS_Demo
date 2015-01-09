//
//  MyTableViewCell.m
//  GetCellLayerDemo
//
//  Created by sfwan on 14-12-17.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MyTableViewCell.h"
@interface MyTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *U;

@end
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIsHehe:(BOOL)isHehe{
    _isHehe = isHehe;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    if (_isHehe) {
        _U.hidden = NO;
    } else {
        _U.hidden = YES;
    }
}

@end
