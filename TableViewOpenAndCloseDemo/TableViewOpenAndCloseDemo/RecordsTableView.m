//
//  RecordsTableView.m
//  TableViewOpenAndCloseDemo
//
//  Created by sfwan on 14-12-12.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "RecordsTableView.h"
#import "RecordsTableCell.h"

@interface RecordsTableView()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation RecordsTableView
{
    // 是否展开外层
    NSMutableDictionary *openDic;
}

-(void)setData:(NSMutableDictionary *)data{
    _data = data;
        
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self _initViews];
}

-(void)_initViews{
    self.dataSource = self;
    self.delegate = self;
    openDic = [NSMutableDictionary dictionary];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *allKeys = [self arraySort];
    NSString *key = allKeys[section];
    BOOL open = [openDic[key] boolValue];
    if (open) {
        NSArray *array2D = _data[key];
        return array2D.count + 1;
    } else {
        return 0;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCellId"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCellId"];
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
            timeLabel.tag = 1999;
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.textAlignment = NSTextAlignmentLeft;
            timeLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:timeLabel];
            
            UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(176, 5, 30, 30)];
            amountLabel.tag = 2000;
            amountLabel.textColor = [UIColor grayColor];
            amountLabel.textAlignment = NSTextAlignmentLeft;
            amountLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:amountLabel];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(175, 10, 1, 22)];
            line.backgroundColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:line];
        }
        cell.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        
        UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:1999];
        UILabel *amountLabel = (UILabel *)[cell.contentView viewWithTag:2000];
        timeLabel.text = @"时间";
        amountLabel.text = @"金额";
        
        return cell;
        
    } else {
        RecordsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (cell == nil) {
            cell = [[RecordsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        }
        
        NSArray *allKeys = [self arraySort];
        NSString *key = allKeys[indexPath.section];
        NSArray *array2D = _data[key];
        cell.model = array2D[indexPath.row -1];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    // 最外层展开是确认是那个按钮点击
    NSString *key = [self arraySort][section];
    NSInteger tag = [key integerValue];
    button.tag = tag;
    
    [button addTarget:self action:@selector(hideCellAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    icon.backgroundColor = [UIColor orangeColor];
    [view addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + 2, 5, 150, 30)];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    label.text = [self stateStringInSection:section];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

#pragma mark - button action
-(void)hideCellAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSString *key = [NSString stringWithFormat:@"%d", tag];
    BOOL open = [openDic[key] boolValue];
    [openDic setObject:[NSNumber numberWithBool:!open] forKey:key];
    
    [self reloadData];
}

#pragma mark - others
-(NSArray *)arraySort{
    NSArray *allkeys = [_data allKeys];
    allkeys = [allkeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {// 根据状态排序 1, 2, 3
        int result = [obj1 integerValue] - [obj2 integerValue];
        if (result == 0) {
            return NSOrderedSame;
        } else if (result > 0) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    return allkeys;
}


-(NSString *)stateStringInSection:(NSInteger)section{
    NSArray *allKeys = [self arraySort];
    NSString *stateStr = allKeys[section];
    NSInteger state = [stateStr integerValue];
    
    switch (state) {
        case 1:return @"待审核";
        case 2:return @"提现中";
        case 3:return @"提现批准";
        case 4:return @"审核失败";
        case 5:return @"已取消";
        case 6:return @"审核失败并退款";
        default:
            return @"服务器又在开玩笑了";
            break;
    }
    
}

@end
