//
//  SFContextView.m
//  ImageDemo
//
//  Created by shaofa on 14-3-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SFContextView.h"

@implementation SFContextView

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
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, rect);
}

@end
