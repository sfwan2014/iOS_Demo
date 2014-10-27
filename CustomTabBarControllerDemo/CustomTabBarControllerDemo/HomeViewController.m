//
//  HomeViewController.m
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomTabBarViewController.h"
#import "SubViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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

}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    static BOOL state = YES;
    CustomTabBarViewController *tabCl = (CustomTabBarViewController *)self.tabBarController;
    if (state) {

        [tabCl hideTabBar:YES];
    } else {
        [tabCl showTabBar:YES];
    }
    
    state = !state;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    SubViewController *sub = [[SubViewController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];
}
@end
