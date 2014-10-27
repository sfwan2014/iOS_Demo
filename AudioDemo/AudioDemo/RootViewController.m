//
//  RootViewController.m
//  AudioDemo
//
//  Created by sfwan on 14-7-29.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "HJCFRecordProvider.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    NSDate *_startDate;
    NSDate *_stopDate;
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

    
}

-(void)buttonAction
{
    [[HJCFRecordProvider shareInstance] startRecordAudio];
    [self timeOn];
    [[HJCFRecordProvider shareInstance] stopRecord];
    [self timeOff];
    //录音时间
    NSDate *date = [NSDate date];
    
    // 文件名
    NSString *fileName = [NSString stringWithFormat:@"%@", date];
    [[HJCFRecordProvider shareInstance] wavToAmrWithArmFileName:fileName];
    
    // 保存 文件名, 录音时间, 录音时长,录音描述 到coredata
    
    // 时长
    NSTimeInterval time = [_stopDate timeIntervalSinceDate:_startDate];
    // 描述
    NSString *destription = @"测试描述";
}

-(void)timeOn
{
    _startDate = [NSDate date];
}

-(void)timeOff
{
    _stopDate = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
