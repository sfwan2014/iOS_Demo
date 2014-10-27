//
//  OrderTableView.m
//  CaculateForCellDemo
//
//  Created by sfwan on 14-10-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "OrderTableView.h"
#import "OrderTableViewCell.h"

@interface OrderTableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *amounts;
@end
@implementation OrderTableView
{
//    __block NSMutableDictionary *amounts;
    BOOL hehe;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    hehe = YES;
    self.dataSource = self;
    self.delegate = self;
    _amounts = [NSMutableDictionary dictionary];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] lastObject];
    }
    
    NSString *key = [NSString stringWithFormat:@"%d", indexPath.row];
    __weak OrderTableView *this = self;
    cell.block = ^(NSArray *result, BOOL isRefresh){
        OrderTableView *strong = this;
        [strong.amounts setObject:result forKey:key];
        if (isRefresh) {
            [strong reloadData];
        }
    };
    
    if (hehe) {
        cell.originalCount = 3;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    hehe = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, 40)];
    label1.textColor = [UIColor blackColor];
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 120, 40)];
    label2.textColor = [UIColor blackColor];
    [view addSubview:label2];
    
    NSArray *allkeys = [_amounts allKeys];
    NSInteger count = 0;
    for (NSString *key in allkeys) {
        NSArray *array = _amounts[key];
        NSInteger c = [[array firstObject] integerValue];
        count += c;
    }
    
    label1.text = [NSString stringWithFormat:@"%d", count];
    
    CGFloat amount = 0;
    for (NSString *key in allkeys) {
        NSArray *array = _amounts[key];
        CGFloat c = [[array lastObject] floatValue];
        amount += c;
    }
    
    label2.text = [NSString stringWithFormat:@"%.2f", amount];

    return view;
}

@end
