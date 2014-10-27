//
//  ViewController.m
//  LocationNotification
//
//  Created by shaofa on 13-12-26.
//  Copyright (c) 2013年 shaofa. All rights reserved.
//

#import "ViewController.h"

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

    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSLog(@">> support local notification");
        NSDate *now=[NSDate new];
        notification.fireDate=[now addTimeInterval:4];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody=@"该去吃晚饭了！";
        [UIApplication sharedApplication].applicationIconBadgeNumber = 99;
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
