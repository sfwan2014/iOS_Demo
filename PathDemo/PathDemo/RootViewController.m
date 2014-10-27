//
//  RootViewController.m
//  PathDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "AnimationView.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    AnimationView *aniview;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    aniview = [[AnimationView alloc] initWithFrame:CGRectMake(0, 40, 50, 50)];
    aniview.imgName = @"success.png";
    [self.view addSubview:aniview];

//    CGPoint point = CGPointMake(290, 400);
//    [aniview addAnimationToPoint:point];
    /*
    //添加图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
    imgView.frame = CGRectMake(100, 100, imgView.frame.size.width, imgView.frame.size.height);
    [self.view addSubview:imgView];

    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(10.0, 10.0)];
    [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
//    [movePath addLineToPoint:CGPointMake(200, 300)];

    //以下必须导入QuartzCore包
    //关键帧动画（位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    //缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    // 旋转动画
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    rotationAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, 1)];
    rotationAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, scaleAnim, opacityAnim, rotationAnim, nil];
    animGroup.duration = 5;

    [imgView.layer addAnimation:animGroup forKey:nil];
     */
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    UIView *view = touch.view;
    if (![view isKindOfClass:[AnimationView class]]) {
        return;
    }
    
    CGPoint point = [touch locationInView:self.view];
    [aniview backToOriginalPosition:point];

    if (point.x < 320/2.0) {
        point = CGPointMake(aniview.frame.size.width/2, point.y);
    } else {
        point = CGPointMake(320 - aniview.frame.size.width/2, point.y);
    }
    
    aniview.center = point;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    UIView *view = touch.view;
    if (![view isKindOfClass:[AnimationView class]]) {
        return;
    }
    
    CGPoint point = [touch locationInView:self.view];
    aniview.center = point;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
