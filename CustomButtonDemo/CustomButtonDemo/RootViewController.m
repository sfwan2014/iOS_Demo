//
//  RootViewController.m
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "CustomButton.h"

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

    NSArray *items = @[@"123", @"231", @"2431"];
    CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, kItemWidth, kItemWidth) items:items target:self selector:@selector(clickAction:)];
    [self.view addSubview:button];
}

-(void)clickAction:(CustomButton *)button{
    button.selected = !button.selected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
