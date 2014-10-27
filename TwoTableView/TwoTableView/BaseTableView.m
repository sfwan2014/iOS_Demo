//
//  BaseTableView.m
//  TwoTableView
//
//  Created by shaofa on 14-1-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(void)setData:(NSArray *)data
{
    _data = data;
    
    // 刷新
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 调用代理 
    if ([self.selectedDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:tableView:)]) {
        [self.selectedDelegate didSelectRowAtIndexPath:indexPath tableView:self];
    }
}

@end
