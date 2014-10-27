//
//  SUbViewController.m
//  NavDemo
//
//  Created by shaofa on 14-6-6.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SUbViewController.h"

@interface SUbViewController ()

@end

@implementation SUbViewController

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
	// Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    self.title = @"导航栏测试";
    
    [self.view addSubview:view];
    view.text = @"(0, 0, 320, 20)";
    view.backgroundColor = [UIColor yellowColor];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    float systemVersion = [[UIDevice currentDevice].systemVersion intValue];
    if (systemVersion >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
        CGRect frame = self.navigationController.navigationBar.superview.frame;
        frame.origin.y = 0;
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.superview.frame = frame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
