//
//  ItemView.m
//  SwipeImageViewDemo
//
//  Created by sfwan on 14-8-5.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView
{
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    imageView.image = [UIImage imageNamed:_item.imageName];
}

-(void)tapAction
{
    NSLog(@"%@", _item.description);
}

@end
