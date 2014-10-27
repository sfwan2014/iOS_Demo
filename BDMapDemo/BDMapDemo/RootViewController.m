//
//  RootViewController.m
//  BDMapDemo
//
//  Created by sfwan on 14-9-5.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "MapPage.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    MapPage *_map;
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
    // Do any additional setup after loading the view from its nib.
    _map = [[MapPage alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_map];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
