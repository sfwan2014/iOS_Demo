//
//  ViewController.m
//  MultiCollectionDemo
//
//  Created by sfwan on 14-10-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ViewController.h"
#import "ProductCenterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)push:(id)sender {
    ProductCenterViewController *product = [[ProductCenterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:product];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
