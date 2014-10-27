//
//  ViewController.m
//  AnimationDemo
//
//  Created by shaofa on 14-2-12.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 30, 30)];
    view.image = [UIImage imageNamed:@"倍数.png"];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 400, 150, 30);
    [button setTitle:@"KeyframeAnim" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(KeyframeAnim) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *buttonPath = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPath.frame = CGRectMake(10, 430, 150, 30);
    [buttonPath setTitle:@"KeyPathAnim" forState:UIControlStateNormal];
    [buttonPath setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonPath addTarget:self action:@selector(KeyPathAnim) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPath];
}

-(void)KeyframeAnim
{
    CAKeyframeAnimation *opAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opAnim.duration = 6;
    opAnim.values = @[[NSNumber numberWithFloat:0.25],
                      [NSNumber numberWithFloat:0.75],
                      [NSNumber numberWithFloat:1.0]];
    opAnim.keyTimes = @[[NSNumber numberWithFloat:0.0],
                        [NSNumber numberWithFloat:0.5],
                        [NSNumber numberWithFloat:1.0]];
    [view.layer addAnimation:opAnim forKey:@"animateOpacity"];
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);

    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    moveAnim.duration = 6.0;
    moveAnim.toValue= [NSValue valueWithCATransform3D:
                       CATransform3DMakeAffineTransform(moveTransform)];
    [view.layer addAnimation:moveAnim forKey:@"animateTransform"];
    
}

-(void)KeyPathAnim
{
    CGMutablePathRef starPath = CGPathCreateMutable();
    CGPathMoveToPoint(starPath,NULL,160.0f, 100.0f);
    CGPathAddLineToPoint(starPath, NULL, 100.0f, 280.0f);
    CGPathAddLineToPoint(starPath, NULL, 260.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 60.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 220.0, 280.0);
    CGPathCloseSubpath(starPath);
    
    CAKeyframeAnimation *animation = nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setDuration:10.0f];
    [animation setDelegate:self];
    [animation setPath:starPath];
    CFRelease(starPath);
    starPath = nil;
    [[view layer] addAnimation:animation forKey:@"position"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
