//
//  MyCell.m
//  TableViewSelectViewDemo
//
//  Created by shaofa on 14-5-29.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.selectedBackgroundView.frame;
    frame.size.width = 300;
    frame.size.height = kCellH - 10;
    frame.origin.x = 10;
    frame.origin.y = 5;
    self.selectedBackgroundView.frame = frame;
}

@end
