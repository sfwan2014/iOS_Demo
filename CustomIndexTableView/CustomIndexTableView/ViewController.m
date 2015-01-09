//
//  ViewController.m
//  CustomIndexTableView
//
//  Created by sfwan on 14-12-31.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet CustomTableView *tableView;

@end

@implementation ViewController{
    NSDictionary *_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @{@"A":@[@"a",@"a",@"a",@"a"],@"B":@[@"b",@"b",@"b",@"b"],@"H":@[@"a",@"a",@"a",@"a"],@"C":@[@"b",@"b",@"b",@"b"],@"D":@[@"a",@"a",@"a",@"a"],@"E":@[@"b",@"b",@"b",@"b"],@"F":@[@"a",@"a",@"a",@"a"],@"G":@[@"b",@"b",@"b",@"b"]};
    _tableView.data = _data;
    
    [self createIndexTableView];
}
#pragma mark - indexTable
-(void)createIndexTableView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UITableView *indexTableView = [[UITableView alloc] initWithFrame:CGRectMake(width-50, 50, 50, 500) style:UITableViewStylePlain];
    indexTableView.delegate = self;
    indexTableView.dataSource = self;
    indexTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    indexTableView.backgroundColor =[UIColor clearColor];
    indexTableView.rowHeight = 500/_data.count;
    [self.view addSubview:indexTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    return allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *key = [allKeys objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView scrollToTheSection:indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
