//
//  RootViewController.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "ClientInfoTableView.h"
#import "ClientInfoHeadView.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet ClientInfoTableView *tableView;
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

    [self _initViews];

    [self _loadLocationData];
}

-(void)_initViews
{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ClientInfoHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"ClientInfoHeadView" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView = headView;
    _tableView.tableHeaderView.height = headView.height;
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ClientInfo.geojson" ofType:nil];
    NSError *error = nil;
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    NSArray *list = [result objectForKey:@"list"];
    
    _tableView.data = list;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
