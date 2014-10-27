//
//  RootViewController.m
//  SegmentControlDemo
//
//  Created by sfwan on 14-7-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "HJCFSegment.h"

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
    
    NSArray *items = @[@"123", @"234", @"345"];
    HJCFSegment *sg = [[HJCFSegment alloc] initWithItems:items target:self selector:@selector(sgAction:)];
    sg.frame = CGRectMake(0, 200, 320, 44);
    sg.selectIndex = 2;
    [self.view addSubview:sg];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe];
}

-(void)swipeAction
{

}

-(void)sgAction:(HJCFSegment *)sg
{
    NSLog(@"%d", sg.selectIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
