//
//  ViewController.m
//  TableViewOpenAndCloseDemo
//
//  Created by sfwan on 14-12-12.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "RecordsTableView.h"
#import "RecordsModel.h"

@interface ViewController ()

@end

@implementation ViewController{
    RecordsTableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableView = [[RecordsTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //{1:[],2:[]....}
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    for (int i = 1; i <= 6; i++) {
        NSMutableArray *array2D = [NSMutableArray array];
        NSString *key = [NSString stringWithFormat:@"%d", i];
        [data setObject:array2D forKey:key];
        // 没有的状况下,建一个无 idStr 属性的model,代表没数据
        if (i == 3) {
            RecordsModel *model = [[RecordsModel alloc] init];
//            model.idStr = key;
            model.confirmtime = @"2014/12/12 12:12:12";
            model.amount = @"3000.00";
            [array2D addObject:model];
            continue;
        }
        
        for (int j = 0; j < 6; j++) {
            RecordsModel *model = [[RecordsModel alloc] init];
            model.idStr = key;
            model.confirmtime = @"2014/12/12 12:12:12";
            model.amount = @"3000.00";
            [array2D addObject:model];
        }
    }
    
    tableView.data = data;
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
