//
//  RootViewController.m
//  TableViewCellTalk
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"
#import "TaskProcessTableView.h"

#define kString1            @"迁移工作提供了一个重访现有。"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet TaskProcessTableView *tableView;


@end

@implementation RootViewController

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

    [self _initData];
}

-(void)_initData
{
    int fileNum = 4;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        NSMutableDictionary *user = [NSMutableDictionary dictionary];
        NSString *username = [NSString stringWithFormat:@"阿达%d号",i+1];
        NSMutableArray *files = [NSMutableArray array];
        
        for (int i = 0; i < fileNum; i++) {
            NSString *filename = [NSString stringWithFormat:@"文件%d.text",i+1];
            [files addObject:filename];
        }
        [user setObject:username forKey:key_username];
        if (i%3 == 0) {
            [user setObject:files forKey:key_files];
        }
        [user setObject:kString1 forKey:key_content];
        
        if (i%2==0) {
            [user setObject:[NSNumber numberWithBool:YES] forKey:key_perstate];
        } else {
            [user setObject:[NSNumber numberWithBool:NO] forKey:key_perstate];
        }
        
        [array addObject:user];
    }
    
    self.tableView.data = array;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
