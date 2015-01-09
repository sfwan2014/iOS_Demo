//
//  SubViewController.m
//  RotateDemo
//
//  Created by sfwan on 14-12-8.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//     [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//    
//    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
//    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
//    //设置旋转动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    //设置导航栏旋转
//    self.navigationController.navigationBar.frame = CGRectMake(-204, 224, 480, 32);
//    self.navigationController.navigationBar.transform = CGAffineTransformMakeRotation(M_PI*1.5);
//    //设置视图旋转
//    self.view.bounds = CGRectMake(0, -54, self.view.frame.size.width, self.view.frame.size.height);
//    self.view.transform = CGAffineTransformMakeRotation(M_PI*1.5);
//    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated{
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//    //view旋转
//    //    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)deviceOrientationDidChange: (NSNotification *)notification

{
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    
    CGAffineTransform rotation;
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            
            break;
            
        default:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            
            break;
            
    }
    
    self.view.transform = rotation;
   
    
}

- (NSUInteger)supportedInterfaceOrientations {
    
    //需要强制横屏
    
    return UIInterfaceOrientationMaskLandscape;
    
}



- (BOOL) shouldAutorotate {
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
