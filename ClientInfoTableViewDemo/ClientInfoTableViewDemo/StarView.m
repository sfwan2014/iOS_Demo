//
//  StarView.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "StarView.h"

@implementation StarView
{
    UIImageView *_redView;
    UIImageView *_grayView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _redView = [[UIImageView alloc] initWithFrame:self.bounds];
    _grayView = [[UIImageView alloc] initWithFrame:self.bounds];
    _redView.backgroundColor = [UIColor redColor];
    _grayView.backgroundColor = [UIColor grayColor];
    [self addSubview:_grayView];
    [self addSubview:_redView];
    
    _redView.layer.masksToBounds = YES;
}

-(void)setValue:(CGFloat)value
{
    if (value >= 5) {
        value = 5;
    }
    
    if (value <= 0) {
        value = 0;
    }
    _value = value;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = _redView.width/5;
    _redView.width = _value * width;
}

@end
