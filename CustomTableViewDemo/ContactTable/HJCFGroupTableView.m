//
//  MyTableView.m
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFGroupTableView.h"
#import "MyCell.h"
#import "SubTableView.h"

@interface HJCFGroupTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HJCFGroupTableView
{
    NSMutableDictionary *openDic;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
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
    openDic = [[NSMutableDictionary alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allKeys = [_data allKeys];
    NSString *key = allKeys[section];
    NSArray *array = _data[key];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil] lastObject];
    }
    
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSString *key = allKeys[indexPath.section];
    NSArray *array = _data[key];
    
    NSDictionary *dic = array[indexPath.row];
    
    cell.data = dic[@"list"];
    BOOL isOpen = [self cellIsOpen:indexPath];
    cell.isOpen = isOpen;
    
    cell.contentLabel.text = dic[@"title"];
    
    return cell;
}

#pragma mark - delegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    return allKeys[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"section:%drow:%d", indexPath.section, indexPath.row];
    NSNumber *isOpenObj = openDic[key];
    BOOL isOpen;
    if (isOpenObj == nil) {
        isOpen = YES;
    } else {
        isOpen = ![isOpenObj boolValue];
    }
    
    [openDic setObject:[NSNumber numberWithBool:isOpen] forKey:key];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableViewCellHeightForIndexPath:indexPath];
}


-(CGFloat)tableViewCellHeightForIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSString *key = allKeys[indexPath.section];
    NSArray *array = _data[key];
    NSDictionary *dic = array[indexPath.row];
    NSArray *lists = dic[@"list"];;
    NSInteger count = lists.count;
    
    BOOL isOpen = [self cellIsOpen:indexPath];
    if (isOpen) {
        return kRowHeight + kSubTableViewCellRowHeight * count;
    } else {
        return kRowHeight;
    }
}

-(BOOL)cellIsOpen:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"section:%drow:%d", indexPath.section, indexPath.row];
    BOOL isOpen = [openDic[key] boolValue];
    return isOpen;
}

@end
