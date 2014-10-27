//
//  SubTableView.m
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SubTableView.h"
#import "SubCell.h"

@interface SubTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SubTableView

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

-(void)setData:(NSArray *)data
{
    _data = data;
    [self reloadData];
}

-(void)_initViews
{
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = kSubTableViewCellRowHeight;
    self.scrollEnabled = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    SubCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:nil
                    options:nil] lastObject];
    }
    
    cell.contentLabel.text = _data[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
