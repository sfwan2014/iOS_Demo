//
//  RootViewController.m
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "HJCFGroupTableView.h"
#import "NSString+SBJSON.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet HJCFGroupTableView *tableView;

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

    [self _loadData];
}

-(void)_loadData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataJson.geojson" ofType:nil];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];;
    NSDictionary *dic = [string JSONValue];
    _tableView.data = dic;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
