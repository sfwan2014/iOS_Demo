//
//  AnimationView.m
//  PathDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView
{
    UIImageView *_imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
}

-(void)setImgName:(NSString *)imgName
{
    _imgName = imgName;
    _imageView.image = [UIImage imageNamed:imgName];
}

-(void)addAnimationToPoint:(CGPoint)point
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.center];
    [path addLineToPoint:point];
    
    CAKeyframeAnimation *posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = path.CGPath;
    posAnim.delegate = self;
    posAnim.removedOnCompletion = YES;
    posAnim.duration = 2.0;
    
    [self.layer addAnimation:posAnim forKey:@"key1"];
}

-(void)backToOriginalPosition:(CGPoint)point
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    
    CGPoint nextPoint = CGPointZero;
    if (point.x < 320/2.0) {
        nextPoint = CGPointMake(self.frame.size.width/2, point.y);
    } else {
        nextPoint = CGPointMake(320 - self.frame.size.width/2, point.y);
    }
    
    [path addLineToPoint:nextPoint];
    
    CAKeyframeAnimation *posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = path.CGPath;
    posAnim.delegate = self;
    posAnim.removedOnCompletion = YES;
//    posAnim.duration = 1.0;
    CGFloat duration = 1.0;
    CGFloat distance = point.x-nextPoint.x;
    if (ABS(distance)>280/2.0) {
        duration = 1.0;
    } else if (ABS(distance) > 50/2.0){
        duration = 0.6;
    } else {
        duration = 0.2;
    }
    
    posAnim.duration = 0.2;
    [self.layer addAnimation:posAnim forKey:@"key2"];
}

-(void)endAnimation
{
    [self.layer removeAnimationForKey:@"key1"];
}

@end
