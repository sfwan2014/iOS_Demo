//
//  CircleView.m
//  CircleProgressView
//
//  Created by nieyun on 14-1-26.
//  Copyright (c) 2014年 changjian. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
      
        UIBezierPath  *path = [UIBezierPath  bezierPath];
        CGRect  rect = frame;
        [path  addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.height/2  startAngle:0 endAngle:2 * M_PI clockwise:YES];
        layer = [CAShapeLayer  layer];
        layer.lineWidth = 5;
        layer.fillColor = [UIColor  clearColor].CGColor;
        
        layer.strokeColor = [UIColor  orangeColor].CGColor;

        
        CAShapeLayer  *layer2 = [CAShapeLayer  layer];
        layer2.path = path.CGPath;
        layer2.lineWidth = 5;
        layer2.fillColor = [UIColor  clearColor].CGColor;
        layer2.strokeColor = [UIColor lightGrayColor].CGColor;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer2];
        [self.layer  addSublayer:layer];
    
        
        [self addAnimation];
        //[layer2  removeAnimationForKey:@"stroke"];
        [self.layer addSublayer:layer];
        
        
        _centerView = [[UIImageView  alloc]initWithFrame:CGRectMake(rect.size.width/2, rect.size.height/2, 15, 15)];
//        _centerView.image = [UIImage  noCacheImageNamed:@"elong-icon_cicle.png"];
        [self  addSubview:_centerView];
        
        
        roundAnimation = [CAKeyframeAnimation  animationWithKeyPath:@"position"];
        roundAnimation.path  = path.CGPath;
        roundAnimation.duration  =120;
        roundAnimation.repeatCount = NSIntegerMax;
        roundAnimation.removedOnCompletion = NO;
        roundAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [roundAnimation  setAutoreverses:NO];
        [_centerView.layer  addAnimation:roundAnimation forKey:ROUND];
    //layer的transform要用3d
        self.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    }
    return self;
}

- (void) addAnimation
{
    circleAnimation =[CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    circleAnimation.repeatCount  =NSIntegerMax;
    circleAnimation.duration = 120;
    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //circleAnimation.speed = 1;
    circleAnimation.fromValue=[NSNumber numberWithInteger:0];
    circleAnimation.toValue =[NSNumber numberWithInteger:1];
    [layer addAnimation:circleAnimation forKey:CIRCLE];
    
    
  // CABasicAnimation  *basic2 = [CABasicAnimation  animationWithKeyPath:@""]
    
}
//- (void) setDuaration:(float)duaration
//{
//    _duaration  =  duaration;
//    circleAnimation.duration =  _duaration;
//    circleAnimation.speed =  _speed;
//    roundAnimation.duration = _duaration;
//    roundAnimation.speed = _speed;
//}



- (void) dealloc
{
    [testView.layer  removeAnimationForKey:@"key"];
    [_centerView.layer  removeAnimationForKey:ROUND];
    [_centerView  release];
    [testView  release];
    [super dealloc];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
