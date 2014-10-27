//
//  ViewController.m
//  UUIDDemo
//
//  Created by shaofa on 14-2-25.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "OpenUDID.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *UUID = [OpenUDID value];
//    NSUUID *UUID = [[UIDevice currentDevice] identifierForVendor];
    NSLog(@"%@", UUID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
