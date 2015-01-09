//
//  MDCustomProgress.m
//  MDCustomProgress
//
//  Created by sfwan on 14-12-18.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDCustomProgress.h"
#define DEFAULT_HEIGHT      7
#define DEFAULT_RADIUS      10

@implementation MDCustomProgress{
    CALayer *_baseLayer;
    CALayer *_normalLayer;
    CALayer *_highlightLayer;
    CAShapeLayer *arcLayer;
}

-(id)initWithFrame:(CGRect)frame normalColor:(UIColor *)norColor highlightColor:(UIColor *)highlightColor{
    self = [super initWithFrame:frame];
    if (self) {
        _normalColor = norColor;
        _highlightColor = highlightColor;
        [self createBaseLayer];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createBaseLayer];
}

-(void)setHighlightColor:(UIColor *)highlightColor{
    _highlightColor = highlightColor;
    _highlightLayer.backgroundColor = highlightColor.CGColor;
    arcLayer.fillColor=_highlightColor.CGColor;
    arcLayer.strokeColor=_highlightColor.CGColor;
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    _normalLayer.backgroundColor = normalColor.CGColor;
}

-(void)createBaseLayer{
    _baseLayer = [[CALayer alloc] init];
    _baseLayer.bounds = self.frame;
    _baseLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:_baseLayer];

    _normalLayer = [[CALayer alloc] init];
    _normalLayer.bounds = CGRectMake(0, 0, self.frame.size.width, DEFAULT_HEIGHT);
    _normalLayer.anchorPoint = CGPointMake(0, 0);
    _normalLayer.position = CGPointMake(0,self.frame.origin.y+(self.frame.size.height-DEFAULT_HEIGHT)/2.0);
    if (_normalColor == nil) {
        _normalColor = [UIColor grayColor];
    }
    _normalLayer.backgroundColor = _normalColor.CGColor;
    [_baseLayer addSublayer:_normalLayer];
    
    
    _highlightLayer = [[CALayer alloc] init];
    _highlightLayer.bounds = CGRectMake(0, 0, 0, DEFAULT_HEIGHT);
    _highlightLayer.anchorPoint = CGPointMake(0, 0);
    _highlightLayer.position = CGPointMake(0,self.frame.origin.y+(self.frame.size.height-DEFAULT_HEIGHT)/2.0);
    if (_highlightColor == nil) {
        _highlightColor = [UIColor orangeColor];
    }
    _highlightLayer.backgroundColor = _highlightColor.CGColor;
    [_baseLayer addSublayer:_highlightLayer];
 
    
    
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0,self.frame.origin.y) radius:DEFAULT_RADIUS startAngle:0 endAngle:2*M_PI clockwise:NO];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;
    arcLayer.fillColor=_highlightColor.CGColor;
    arcLayer.strokeColor=_highlightColor.CGColor;
    arcLayer.position = CGPointMake(DEFAULT_RADIUS, self.frame.size.height/2.0);
    [_baseLayer addSublayer:arcLayer];
}

-(void)setProgress:(CGFloat)progress animation:(BOOL)animation{
    
    progress = MAX(0, progress);
    progress = MIN(1, progress);
    
    CGFloat xx = self.frame.size.width/100.0;
    
    _highlightLayer.bounds = CGRectMake(0, self.frame.origin.y+(self.frame.size.height-DEFAULT_HEIGHT)/2.0, xx*100 * progress-DEFAULT_RADIUS/2.0, DEFAULT_HEIGHT);
    xx = xx * progress * 100-DEFAULT_RADIUS;
    xx = MAX(xx, DEFAULT_RADIUS);
    arcLayer.position = CGPointMake(xx, self.frame.size.height/2.0);
}

@end
