//
//  RootViewController.m
//  SwipeImageViewDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "SwipeView.h"

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
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        Item *item = [[Item alloc] init];
        item.imageName = [NSString stringWithFormat:@"%d.jpg", i+1];
        [items addObject:item];
    }
    SwipeView *view = [[SwipeView alloc] initWithFrame:CGRectMake(0, 100, 320, 200) items:items];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
