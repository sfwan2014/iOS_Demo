//
//  HJCFProgressView.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFProgressView.h"

@implementation HJCFProgressView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    __weak IBOutlet UILabel *progressLabel;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.frame = self.layer.bounds;
    
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.frame = self.layer.bounds;
    
    self.progressWidth = 5;
    
    self.layer.cornerRadius = self.frame.size.width/2.0;
}

-(void)setTrack
{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.layCenter radius:(self.bounds.size.width-_progressWidth)/2 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    _trackLayer.path = _trackPath.CGPath;
}

-(CGPoint)layCenter
{
    CGPoint center = _trackLayer.frame.origin;
    center.x += _trackLayer.frame.size.width/2;
    center.y += _trackLayer.frame.size.height/2;
    return center;
}

-(void)setProgress
{
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.layCenter radius:(self.bounds.size.width-_progressWidth)/2 startAngle:-M_PI_2 endAngle:(M_PI * 2)*_progress-M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}

-(void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    
    [self setTrack];
    [self setProgress];
}

-(void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress*100];
    [self setProgress];
}

-(void)setProgress:(float)progress animated:(BOOL)animated
{
    _progress = progress;
    [self setProgress];
    progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress*100];
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=4;
    bas.speed = 0.1;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:1];
    bas.toValue=[NSNumber numberWithInteger:1];
    [_progressLayer addAnimation:bas forKey:@"key"];
}

@end
