//
//  CustomGroupTableView.m
//  CustomGroupTableView
//
//  Created by sfwan on 14-10-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomGroupTableView.h"
#import "CustomGroupCell.h"

@interface CustomGroupTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation CustomGroupTableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
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
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    CustomGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomGroupCell" owner:nil options:nil] lastObject];
    }
    
    cell.style = indexPath.row;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 2) {
        return 102;
    } else if (indexPath.row < 4) return 200;
    
    return 200;
}

@end
