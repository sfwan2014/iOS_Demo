//
//  ChartFillView.m
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ChartFillView.h"

@implementation ChartFillView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initLayer];
    }
    return self;
}

-(void)_initLayer
{
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [UIColor greenColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
    _trackLayer.path = path.CGPath;
    self.backgroundColor = [UIColor clearColor];
    
    [self addAnimation];
}

-(void)setTrack:(CGFloat)height
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height-height, self.frame.size.width, height)];
    _trackLayer.path = path.CGPath;
}

-(void)addAnimation
{
//    CGRect frame = self.frame;
//    frame.size.height = 100;
//    frame.origin.y = 100;
//    self.transform = CGAffineTransformRotate(self.transform, -M_PI);
//    [UIView animateWithDuration:2 animations:^{
//        self.frame = frame;
//    }];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fromValue = @0;
    anim.toValue = @1;
    
//    bas.duration=4;
//    bas.speed = 0.1;
//    bas.delegate=self;
//    bas.fromValue=[NSNumber numberWithInteger:1];
//    bas.toValue=[NSNumber numberWithInteger:1];
    [_trackLayer addAnimation:anim forKey:@"key"];
}

@end
