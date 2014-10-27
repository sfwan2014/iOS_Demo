//
//  RootViewController.m
//  TwoTableView
//
//  Created by shaofa on 14-1-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "RootViewController.h"
#import "RightTableView.h"

@interface RootViewController ()<BaseTableViewSelectedDelegate>

@end

@implementation RootViewController
{
    RightTableView *rightTableView;
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

    NSMutableArray *leftData = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSString *str1 = [NSString stringWithFormat:@"left--%d",i];
        [leftData addObject:str1];
    }
    
    float width = [UIScreen mainScreen].bounds.size.width;
    BaseTableView *leftTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, width / 4, self.view.frame.size.height) style:UITableViewStylePlain];
    
    rightTableView = [[RightTableView alloc] initWithFrame:CGRectMake(width/4, 0, width - width/4, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:leftTableView];
    [self.view addSubview:rightTableView];
    // 设置选中代理
    leftTableView.selectedDelegate = self;
    leftTableView.data = leftData;
}

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(BaseTableView *)tableView
{
    NSString *str = tableView.data[indexPath.row];
    
    NSMutableArray *rightData = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSString *str2 = [NSString stringWithFormat:@"(%@, right--%d)", str, i];
        [rightData addObject:str2];
    }
    
    rightTableView.data = rightData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
