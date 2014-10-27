//
//  RootViewController.m
//  MenuViewDemo
//
//  Created by sfwan on 14-8-8.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "MenuView.h"

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
- (IBAction)showAction:(id)sender {
    CGRect frame = CGRectMake(10, 100, 0, 40);
    NSArray *items = @[@"呵呵"];
    [MenuView showInView:self.view frame:frame withTitles:items arrowDirector:kArrowDirectionUp clickBlock:^(MenuView *view, NSString *title) {
        NSLog(@"%@", title);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
