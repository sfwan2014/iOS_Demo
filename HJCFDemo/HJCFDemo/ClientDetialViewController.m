//
//  ClientDetialViewController.m
//  HJCFDemo
//
//  Created by sfwan on 14-7-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientDetialViewController.h"
#import "TWRChartView.h"
#import "NSObject+SBJSON.h"


#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWIdth    [UIScreen mainScreen].bounds.size.width

@interface ClientDetialViewController ()

@end

@implementation ClientDetialViewController
{
    TWRChartView *_chartView;
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

    _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWIdth, 2*kScreenHeight/5)];
    _chartView.backgroundColor = [UIColor clearColor];
    
//    [{value : 89, color: "#D97041"}]
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:i*2 + 30], @"value", [NSString stringWithFormat:@"#D%d", 97000+i*50], @"color", nil];
        [array addObject:dic];
    }
    
    NSString *jsonString = [array JSONRepresentation];
    _chartView.jsonString = jsonString;
    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    [_chartView setChartJsFilePath:jsFilePath];
    
    // Add the chart view to the controller's view
    [self.view addSubview:_chartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
