//
//  ItemView.m
//  PasswordInputViewDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView
{
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width/2.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initWIthImage:(UIImage *)image frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.layer.cornerRadius = frame.size.width/2.0;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

@end
