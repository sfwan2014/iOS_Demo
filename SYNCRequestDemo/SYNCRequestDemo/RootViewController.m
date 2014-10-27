//
//  RootViewController.m
//  SYNCRequestDemo
//
//  Created by sfwan on 14-8-20.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "SYNCHTTPRequest.h"

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
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:nil];
    [[SYNCHTTPRequest shareManager] postWithRequest:request callBack:^(const NSString *requestType, NSString *info, NSError *error) {
        if ([requestType isEqualToString:SYNCHTTPRequestStartBackgroundRequest]) {
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
