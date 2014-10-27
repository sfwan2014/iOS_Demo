//
//  RootViewController.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "HJCFActivityView.h"
#import "HJCFSucceedView.h"
#import "HJCFUtils.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    HJCFProgressView *progress;
    NSTimer *_timer;
}

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

//    [HJCFUtils showHUBToView:self.view];
//    progress = [HJCFUtils showProgressViewToView:self.view];
    
    NSError *error = [NSError errorWithDomain:@"123" code:kErrorCodeTypeOutTime userInfo:nil];
    [HJCFUtils SHowErrorMessage:error];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
//    [self.view addSubview:success];
}

-(void)timeAction:(NSTimer *)timer
{
    static float pro = 0;
    
    if (pro >= 1) {
        [timer invalidate];
        pro = 0;
        [HJCFUtils showSucceedToView:self.view];
        return;
    }
    
    [progress setProgress:pro];
    pro += 0.0001;
}

- (IBAction)testAction:(id)sender {
}

-(void)buttonAction
{
    static int num = 0;
    
    if (num == 0) {
        [HJCFUtils showHUBToView:self.view withMsg:@"加载提示框"];
    } else if (num == 1) {
        [HJCFUtils showSucceedToView:self.view];
    } else if (num == 2){
        progress = [HJCFUtils showProgressViewToView:self.view];
        
        if (_timer != nil) {
            [_timer invalidate];
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        
    } else {
        num = -1;
        [HJCFUtils hideHUBFromView:self.view];
    }
    
    num ++;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
