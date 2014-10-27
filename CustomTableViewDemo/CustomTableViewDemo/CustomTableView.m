//
//  CustomTableView.m
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomTableView.h"

@interface CustomTableView ()<UIScrollViewDelegate>

@end

@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)_initView
{
    self.delegate = self;
}

@end
