//
//  RootViewController.m
//  SpeechDemo
//
//  Created by sfwan on 14-6-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "AddressViewController.h"

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
}
- (IBAction)addressBookAction:(id)sender {
    
    AddressViewController *address = [[AddressViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:address];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (IBAction)playVoiceAction:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
