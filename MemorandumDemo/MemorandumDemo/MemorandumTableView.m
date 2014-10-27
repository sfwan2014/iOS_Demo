//
//  MemorandumTableView.m
//  MemorandumDemo
//
//  Created by sfwan on 14-8-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MemorandumTableView.h"

@implementation MemorandumTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)reloadData
{
    
}

- (NSInteger)sections
{
    return 0;
}

- (UIView *)sectionHeadView
{
    return nil;
}

- (UIView *)cellForIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGFloat)rowHeight
{
    return 0;
}

@end
