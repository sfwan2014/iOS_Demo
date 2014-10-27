//
//  ViewController.m
//  RandomDemo
//
//  Created by shaofa on 14-4-10.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "BOCOPRandom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *str = [BOCOPRandom createRandom];
    NSLog(@"%@", str);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
