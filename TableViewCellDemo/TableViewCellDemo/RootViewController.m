//
//  RootViewController.m
//  TableViewCellDemo
//
//  Created by shaofa on 14-6-9.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"
#import "MyCell.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, MyCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController
{
    NSMutableArray *_data;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"文件%d", i];
        [_data addObject:str];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
    }
    
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    } else {
        cell.isFirst = NO;
    }
    
    if (indexPath.row < _data.count) {
        cell.text = _data[indexPath.row];
    }
    
    return cell;
}

-(void)MyCellDeleteItem:(MyCell *)cell item:(id)item
{
    NSUInteger index = [_data indexOfObject:item];
    [_data removeObject:item];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:1];
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 87;
    } else if (indexPath.row == _data.count) {
        return 59;
    }
    
    return 44;
}

-(void)MyCellAddItem:(MyCell *)cell item:(id)item
{
//    [_data addObject:it];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
