//
//  RootViewController.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "RootViewController.h"
#import "AddViewController.h"
#import "BaseDBManager.h"
#import "Model.h"
#import "DetailViewController.h"
#import "EditViewController.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) NSMutableArray *data;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _initNavigationItem];
}

-(void)_initNavigationItem
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    addButton.frame = CGRectMake(0, 0, 50, 40);
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(0, 0, 50, 40);
    [deleteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[addItem, deleteItem];
    
    UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [findButton setTitle:@"查找" forState:UIControlStateNormal];
    findButton.frame = CGRectMake(0, 0, 50, 40);
    [findButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *findItem = [[UIBarButtonItem alloc] initWithCustomView:findButton];
    [findButton addTarget:self action:@selector(findAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = findItem;
    
}

-(void)addAction
{
    AddViewController *add = [[AddViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)deleteAction:(UIButton *)button
{
    //tableView是否为编辑模式
    BOOL editing = _tableView.editing;
    
    [_tableView setEditing:!editing animated:YES];
    
    if (!editing) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"删除" forState:UIControlStateNormal];
    }
    
    if (self.data.count == 0) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
    }
}

-(void)findAction
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"kCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == Nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    
    Model *model = self.data[indexPath.row];
    cell.textLabel.text = model.clsName;
    cell.detailTextLabel.text = model.iDMCC;
    
    return cell;
}


#pragma mark - tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Model *model = self.data[indexPath.row];
    EditViewController *detail = [[EditViewController alloc] init];
    detail.MCC = model.iDMCC;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {

        
    } else if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        Model *model = self.data[indexPath.row];
        //删除数据
        [BaseDBManager deleteModel:model.iDMCC];
        [self.data removeObjectAtIndex:indexPath.row];
        //tabelView中删除一个单元格视图
        NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *allModels = [BaseDBManager findAllModels];
    NSMutableArray *array = [NSMutableArray arrayWithArray:allModels];
    if (array.count == 0) {
        return;
    }
    self.data = nil;
    
    self.data = array;
    
    [self.tableView reloadData];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
