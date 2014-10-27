//
//  ViewController.m
//  NavDemo
//
//  Created by shaofa on 14-6-6.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "SUbViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor yellowColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 100, 70, 35);
    [self.view addSubview:btn];
}

-(void)buttonAction:(UIButton *)bt
{
    SUbViewController *sub = [[SUbViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sub];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
//    [self.navigationController pushViewController:sub animated:YES];
}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
//    self.view.bounds = viewBounds;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.superview.bounds = viewBounds;
    self.view.superview.backgroundColor = [UIColor blackColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.superview.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
