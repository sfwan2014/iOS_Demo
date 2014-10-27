//
//  ReviewViewController.m
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ReviewViewController.h"
#import "HJCFRecordTools.h"
#import "HJCFAudioTurnFormat.h"
#import "HJCFRecordProvider.h"

typedef enum : NSInteger {
    kOperationTypeDelete = 1,
    kOperationTypeTurn,
    kOperationTypePlay,
} kOperationType;

@interface ReviewViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ReviewViewController
{
    NSMutableArray *data;
    NSMutableArray *buttons;
    kOperationType operationType;
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

    
    buttons = [[NSMutableArray alloc] init];
    
    [self restore];
    
    [self _loadNavigationItem];
}

-(void)restore
{
    data = [[HJCFRecordTools allAudioFilesInCacheDirectory] mutableCopy];
}

-(void)_loadNavigationItem
{
    for (int i = 1; i < 4; i++) {
        NSString *title = i == 1? @"删除模式":i==2?@"转换模式":@"播放模式";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 35);
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:buttons.count];
    for (UIButton *btn in buttons) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    self.navigationItem.rightBarButtonItems = items;
}

-(void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case kOperationTypeTurn:
        {
            operationType = kOperationTypeTurn;
        }
            break;
        case kOperationTypeDelete:
        {
            operationType = kOperationTypeDelete;
        }
            break;
        case kOperationTypePlay:
        {
            operationType = kOperationTypePlay;
        }
            break;
            
        default:
            break;
    }
    
    for (UIButton *btn in buttons) {
        if (button != btn) {
            btn.enabled = YES;
        } else {
            btn.enabled = NO;
        }
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileName = [data objectAtIndex:indexPath.row];
    NSString *filePath = [HJCFRecordTools audioFilePathFromFileName:fileName];
    if (operationType == kOperationTypeTurn) {
//        NSString *wavFilePath = [HJCFRecordTools audioFilePathFromFileName:fileName];
        if ([filePath hasSuffix:@".wav"]) {
            NSString *amrFilePath = [HJCFRecordTools audioFilePathFromFileName:[NSString stringWithFormat:@"%@%@", [fileName substringToIndex:fileName.length - 4], @".amr"]];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:amrFilePath]) {
                return;
            }
            
            if ([HJCFAudioTurnFormat wavToAmr:filePath amrSavePath:amrFilePath]) {
                NSLog(@"succeed");
            } else {
                NSLog(@"failure");
            }
        } else {
            NSString *wavFilePath = [HJCFRecordTools audioFilePathFromFileName:[NSString stringWithFormat:@"%@%@", [fileName substringToIndex:fileName.length - 4], @".wav"]];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:wavFilePath]) {
                return;
            }
            
            if ([HJCFAudioTurnFormat amrToWav:filePath wavSavePath:wavFilePath]) {
                NSLog(@"succeed");
            } else {
                NSLog(@"failure");
            }
        }
        
        [self restore];
        [tableView reloadData];
        
    } else if (operationType == kOperationTypeDelete) {
        [HJCFRecordTools deleteAudioForKey:fileName];
        [data removeObject:fileName];
        [tableView reloadData];
        [[HJCFRecordProvider shareInstance] stopPlayeAudio];
    } else if (operationType == kOperationTypePlay) {
        [[HJCFRecordProvider shareInstance] playRecordAudio:[NSURL fileURLWithPath:filePath]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
