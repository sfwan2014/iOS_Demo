//
//  RootViewController.m
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "ChartCoordinateView.h"
#import "ChartLineView.h"

@interface RootViewController ()<ChartCoordinateViewDataSource>

@end

@implementation RootViewController
{
    NSArray *rowData;
    NSArray *colData;
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

    
    rowData = @[@"行1", @"行2", @"行3", @"行4"];
    colData = @[@"列1", @"列2", @"列3", @"列4"];
    
//    ChartCoordinateView *line = [[ChartCoordinateView alloc] initWithFrame:CGRectMake(70, 70, 200, 200)];
//    line.backgroundColor = [UIColor whiteColor];
//    line.dataSource = self;
//    line.lineColor = [UIColor blueColor];
//    [self.view addSubview:line];
    
    ChartLineView *lineView = [[ChartLineView alloc] initWithFrame:CGRectMake(70, 70, 200, 200)];
    lineView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lineView];
    lineView.rowData = rowData;
    lineView.coluData = colData;
}

-(NSString *)chartCoordinateViewRowTitle:(ChartCoordinateView *)coordinateView
{
    return @"行标题";
}

-(NSString *)chartCoordinateViewColumnsTitle:(ChartCoordinateView *)coordinateView
{
    return @"列标题";
}

-(NSInteger)chartCoordinateViewRows:(ChartCoordinateView *)coordinateView
{
    return rowData.count;
}

-(NSInteger)chartCoordinateViewColumns:(ChartCoordinateView *)coordinateView
{
    return colData.count;
}

-(NSString *)chartCoordinateViewRowSubTitle:(ChartCoordinateView *)coordinateView inRow:(NSInteger)row
{
    return rowData[row];
}
-(NSString *)chartCoordinateViewColumnsSubTitle:(ChartCoordinateView *)coordinateView inColumn:(NSInteger)column
{
    return colData[column];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
