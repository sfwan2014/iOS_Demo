//
//  QuestionTableView.m
//  LogViewDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "QuestionTableView.h"
#import "QuestionCell.h"

static NSString *const TableViewCellIdentifier = @"cellId";

@interface QuestionTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation QuestionTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:nil options:nil] firstObject];
    }
    
    NSString *text = self.data[indexPath.row];
    cell.content = text;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self.data objectAtIndex:indexPath.row];
    text = [Tools handleContent:text];
    if (text.length == 0) {
        return 0;
    }
    CGFloat height = [Tools cellHeightFromContent:text];
    return height;
}

@end
