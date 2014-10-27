//
//  ViewController.m
//  DateDemo
//
//  Created by shaofa on 14-4-5.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *time1 = @"20141205";
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyyMMdd";
    NSDate *date = [formater dateFromString:time1];
    formater.dateFormat = @"YYYY-MM-dd";
    NSString *timeStr = [formater stringFromDate:date];
    NSLog(@"%@", timeStr);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
