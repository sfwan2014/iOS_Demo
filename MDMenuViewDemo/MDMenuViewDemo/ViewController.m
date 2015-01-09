//
//  ViewController.m
//  MDMenuViewDemo
//
//  Created by sfwan on 14-12-24.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "MDMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = @[@"其他资产", @"银行存款", @"宝宝", @"股票", @"基金", @"银行理财", @"信托资管"];
    MDMenuView *menu = [[MDMenuView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height-300/2), 375, 375) titles:titles];
    menu.backgroundColor = [UIColor grayColor];
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
