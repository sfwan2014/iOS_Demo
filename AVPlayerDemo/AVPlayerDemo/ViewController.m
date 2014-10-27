//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by shaofa on 14-2-26.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"xxxxx"];
    NSError *error;
    AVAudioPlayer *avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [avPlayer play];
    
    MPMoviePlayerViewController *mp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:mp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}

@end
