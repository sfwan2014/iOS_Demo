//
//  MDMenuOverlayer.m
//  MDMenuViewDemo
//
//  Created by sfwan on 14-12-24.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDMenuOverlayer.h"
@interface MDMenuOverlayer()
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) UIBezierPath *path;
@end
@implementation MDMenuOverlayer
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _centerPoint = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        self.radius = frame.size.height/2;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    if (self.fillColor == nil) {//49 99 134
        self.fillColor = [UIColor colorWithRed:49/255.0 green:99/255.0 blue:134/255.0 alpha:0.5];
    }
    
    self.path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:self.radius startAngle:M_PI endAngle:2* M_PI clockwise:YES];
    [self.path closePath];
    [self.fillColor set];
    [self.path fill];
}

@end
