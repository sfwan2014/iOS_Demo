//
//  ViewController.m
//  FiltrateDemo
//
//  Created by sfwan on 14-9-10.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ViewController.h"
#import "FiltrateView.h"

@interface ViewController ()

@end

@implementation ViewController

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
    self.view.backgroundColor = [UIColor cyanColor];
    
    FiltrateView *fView = [[FiltrateView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:fView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
