//
//  CustomTableView.m
//  CustomIndexTableView
//
//  Created by sfwan on 14-12-31.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "CustomTableView.h"

#define kHeadHeight         30
#define kRowHeight          44

@interface CustomTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation CustomTableView{
    NSMutableArray *positions;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
    self.rowHeight = kRowHeight;
}

-(void)getHeadViewPosition{
    
    NSInteger sections = self.data.count;
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    positions = [NSMutableArray array];
    CGFloat yy = 0;
    [positions addObject:[NSValue valueWithCGPoint:CGPointZero]];
    for (int i = 1; i < sections; i++) {
        NSString *key = [allKeys objectAtIndex:i-1];
        NSArray *array = _data[key];
        NSInteger count = array.count;
        
        CGFloat y = kRowHeight * count+kHeadHeight+yy;
        CGPoint p = CGPointMake(0, y);
        NSLog(@"%f %f",y, yy);
        yy = y;
        [positions addObject:[NSValue valueWithCGPoint:p]];
    }
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    [self getHeadViewPosition];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *key = [allKeys objectAtIndex:section];
    NSArray *array = _data[key];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *key = [allKeys objectAtIndex:indexPath.section];
    NSArray *array = _data[key];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeadHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, kHeadHeight)];
    label.backgroundColor = [UIColor cyanColor];
    
    
    NSArray *allKeys = [_data allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *key = [allKeys objectAtIndex:section];
    label.text = key;
    return label;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)scrollToTheSection:(NSInteger)section{
    
    CGPoint contentOffSet = [positions[section] CGPointValue];
    
    if (contentOffSet.y >= self.contentSize.height-self.frame.size.height) {
        contentOffSet = CGPointMake(0, self.contentSize.height-self.frame.size.height);
    }
    
    [self setContentOffset:contentOffSet animated:YES];
}

@end
