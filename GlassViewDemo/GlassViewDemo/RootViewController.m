//
//  RootViewController.m
//  GlassViewDemo
//
//  Created by sfwan on 14-7-18.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "SFGlassView.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    SFGlassView *view;
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

    view = [[SFGlassView alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
    [self.view addSubview:view];
}
- (IBAction)sliderAction:(UISlider *)sender {
    view.opacity = sender.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
