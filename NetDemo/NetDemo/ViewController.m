//
//  ViewController.m
//  NetDemo
//
//  Created by shaofa on 14-1-9.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "Network.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 200, 100, 30);
    [button setTitle:@"请求网络" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

-(void)buttonAction:(UIButton *)button
{
    [Network downLoadWithUrl:@"http://code4app.com/down/27062d93d244eb851acd597d16552816/?id=51e74b826803faad28000000" fileName:@"sfDemo"];
}

-(void)timeAction
{
    static int t = 0;
    UILabel *label = (UILabel *)[self.view viewWithTag:2013];
    if (label ==nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(100, 240, 100, 30)];
        label.tag = 2013;
        [self.view addSubview:label];
        label.textColor = [UIColor cyanColor];
    }
    
    label.text = [NSString stringWithFormat:@"%d", t];
    t++;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
