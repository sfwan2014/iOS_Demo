//
//  ClientBackgroundCell.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientBackgroundCell.h"
#import "ClientInfoCell.h"

@interface ClientBackgroundCell ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ClientBackgroundCell

- (void)awakeFromNib
{
    [self _initViews];
}

-(void)_initViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.width/2.0;
    _imgView.layer.borderColor = [UIColor grayColor].CGColor;
    _imgView.layer.borderWidth = 1.0;
    
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSArray *thingList = _data[@"thingList"];
    CGFloat height = 0;
    for (NSDictionary *subDict in thingList) {
        height += [ClientInfoTool cellHeightForContent:subDict];
    }
    _tableView.height = height;
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    [_tableView reloadData];
    [self setNeedsLayout];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *thingList = _data[@"thingList"];
    return thingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellID";
    ClientInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientInfoCell" owner:nil options:nil] lastObject];
    }
    
    NSArray *thingList = _data[@"thingList"];
    cell.data = thingList[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *thingList = _data[@"thingList"];
    NSDictionary *dic = thingList[indexPath.row];
    CGFloat height = [ClientInfoTool cellHeightForContent:dic];
    return height;
}

@end
