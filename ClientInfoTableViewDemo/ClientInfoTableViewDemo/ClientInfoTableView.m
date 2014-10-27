//
//  ClientInfoTableView.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientInfoTableView.h"
#import "ClientInfoCell.h"
#import "ClientBackgroundCell.h"

@interface ClientInfoTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ClientInfoTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews];
}

-(void)_initViews
{
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellID";
    ClientBackgroundCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientBackgroundCell" owner:nil options:nil] lastObject];
    }
    
    NSDictionary *dic = [_data objectAtIndex:indexPath.row];
    cell.data = dic;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_data objectAtIndex:indexPath.row];
    NSArray *thingList = dic[@"thingList"];
    CGFloat height = 0;
    for (NSDictionary *subDict in thingList) {
        height += [ClientInfoTool cellHeightForContent:subDict];
    }
    
    return height + kHeadHeight;
}

@end
