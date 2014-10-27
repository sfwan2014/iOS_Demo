//
//  SoundView.m
//  SoundWaveDemo
//
//  Created by shaofa on 14-3-12.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "SoundView.h"

@implementation SoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self performSelector:@selector(animationAction) withObject:Nil afterDelay:3];
    }
    
    return self;
}

-(void)animationAction
{
    CAShapeLayer *shape = [CAShapeLayer layer];

    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=4;
    bas.speed = .1;
    bas.delegate=self;
    //    bas.fromValue=[NSNumber numberWithInteger:0];
    //    bas.toValue=[NSNumber numberWithInteger:1];
    [shape addAnimation:bas forKey:@"key"];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *zeroLine = [UIBezierPath bezierPath];
    [zeroLine moveToPoint:CGPointMake(0, 100)];
    [zeroLine addLineToPoint:CGPointMake(300, 200)];
    zeroLine.lineWidth = 2; // line width
    [zeroLine stroke];
    
}

@end
