//
//  SubViewController.m
//  PopDemo
//
//  Created by shaofa on 14-3-31.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SubViewController.h"
#import "SFTableView.h"

@interface SubViewController ()
@property (weak, nonatomic) IBOutlet SFTableView *tableView;

@end

@implementation SubViewController

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





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
