//
//  FiltrateView.m
//  FiltrateDemo
//
//  Created by sfwan on 14-9-10.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "FiltrateView.h"
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width

@implementation FiltrateView
{
    UITableView *_filtrateListView; // 删选条件列表
    UIView *_bgView;                // 删选背景
    UIView *_btnBgView;             // 按钮背景
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 70, kScreenWidth - 10 * 2, kScreenWidth - 10 * 4)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    _filtrateListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height - 40) style:UITableViewStylePlain];
    _filtrateListView.dataSource = self;
    _filtrateListView.delegate = self;
    _filtrateListView.backgroundColor = [UIColor clearColor];
    _filtrateListView.rowHeight = _filtrateListView.frame.size.height / 5.0;
    [_bgView addSubview:_filtrateListView];
    
    _btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _bgView.frame.size.height - 40, _bgView.frame.size.width, 40)];
    _btnBgView.backgroundColor = [UIColor clearColor];
    [_bgView addSubview:_btnBgView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

@end














