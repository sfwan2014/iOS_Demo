//
//  TopScrollView.m
//  LeafTableViewDemo
//
//  Created by sfwan on 14-7-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "TopScrollView.h"

@implementation TopScrollView
{
    NSMutableArray *imageViews;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews];
}

-(void)_initViews
{
    self.delegate = self;
    imageViews = [[NSMutableArray alloc] init];
    CGFloat width = self.frame.size.width;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"bg.jpg"];
        [self addSubview:imageView];
        [imageViews addObject:imageView];
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
}

-(void)scrollToContentOffSet:(CGPoint)point
{
    self.contentOffset = point;
}

@end
