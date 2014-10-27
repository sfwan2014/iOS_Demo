//
//  MyCell.m
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MyCell.h"
#import "ContactTableView.h"
#import "SubTableView.h"

@implementation MyCell
{
    SubTableView *tableView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self _initViews];
}

-(void)_initViews
{
    tableView = [[SubTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.contentView addSubview:tableView];
}

-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.textLabel.frame;
    frame.origin.y = 5;
    self.textLabel.frame = frame;
    if (_isOpen) {
        tableView.frame = CGRectMake(0, kRowHeight, self.frame.size.width, self.frame.size.height - kRowHeight);
        tableView.data = self.data;
    } else {
        tableView.frame = CGRectZero;
    }
}

@end
