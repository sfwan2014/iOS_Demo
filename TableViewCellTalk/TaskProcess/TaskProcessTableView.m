//
//  TaskProcessTableView.m
//  TableViewCellTalk
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "TaskProcessTableView.h"
#import "TaskProcessCell.h"

@interface TaskProcessTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TaskProcessTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];
}

-(void)_initView
{
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    TaskProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TaskProcessCell" owner:nil options:nil] lastObject];
    }
    
    cell.data = self.data[indexPath.row];
    
    return cell;
}

#pragma mark table delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TaskProcessCell cellContentHeightFromData:self.data[indexPath.row]];
}

@end
