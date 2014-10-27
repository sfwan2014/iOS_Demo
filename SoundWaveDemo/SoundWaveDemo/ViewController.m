//
//  ViewController.m
//  SoundWaveDemo
//
//  Created by shaofa on 14-3-12.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "SoundView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    SoundView *_soundView;
    SoundView *_soundView1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = self.view.bounds;
    frame.size.width = 300;
    frame.origin.x = 10;
    
    _soundView = [[SoundView alloc] initWithFrame:frame];
    _soundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_soundView];
//    _soundView.alpha = 0.0;
    
//    _soundView1 = [[SoundView alloc] initWithFrame:self.view.bounds];
//    _soundView1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_soundView1];
    
    [self lineAnimation];
}

-(void)lineAnimation
{
//    CGRect lastFrame = _soundView.frame;
//    lastFrame.origin.x = 0;
//    CGRect currentFrame = lastFrame;
//    currentFrame.origin.x = -300;
//    _soundView.frame = currentFrame;
//    
//    [UIView animateWithDuration:5 animations:^{
//        _soundView.frame = lastFrame;
//        _soundView.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [self lineAnimation];
//    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
