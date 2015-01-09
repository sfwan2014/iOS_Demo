//
//  Circle.m
//  ShapeDemo
//
//  Created by sfwan on 15-1-5.
//  Copyright (c) 2015年 MIDUO. All rights reserved.
//

#import "Circle.h"

@interface Circle ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) CGPoint controlCenter;
@property (nonatomic, assign) CGFloat radius;
@end

@implementation Circle

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _controlCenter = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

@end
