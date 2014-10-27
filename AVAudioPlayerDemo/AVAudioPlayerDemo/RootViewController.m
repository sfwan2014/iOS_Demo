//
//  RootViewController.m
//  AVAudioPlayerDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "AudioToolbox.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    // Do any additional setup after loading the view from its nib.
    NSString *urlstring = @"/Users/wanshaofa/Downloads/123.mp3";
    NSURL *url = [[NSURL alloc] initFileURLWithPath:urlstring];
    AudioToolbox *tools = [[AudioToolbox alloc] init];
    [tools play:(__bridge CFURLRef)(url)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
