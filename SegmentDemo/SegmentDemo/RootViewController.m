//
//  RootViewController.m
//  SegmentDemo
//
//  Created by sfwan on 14-8-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "HJCFSexChoose2.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet HJCFSexChoose2 *segmentSS;

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
    HJCFSexChoose2 *seg = [[HJCFSexChoose2 alloc] initWithFrame:CGRectMake(0, 100, 320, 50) target:self selector:@selector(segAction:)];
    seg.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:seg];
    
    [_segmentSS addTarget:self action:@selector(segAction:)];
}

-(void)segAction:(HJCFSexChoose2 *)sg
{
    NSLog(@"%d", sg.selectedIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
