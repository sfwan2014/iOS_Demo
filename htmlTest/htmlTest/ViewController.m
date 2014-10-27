//
//  ViewController.m
//  htmlTest
//
//  Created by shaofa on 14-1-6.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 100, 100, 40);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(void)buttonAction
{
    SecondViewController *sv = [[SecondViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sv];
    
    [self presentViewController:nav animated:YES completion:Nil];
//    [self.navigationController pushViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
