//
//  ViewController.m
//  NSKeyedArchiverDemo
//
//  Created by shaofa on 14-3-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "ItemModel.h"
#import "Tools.h"

@interface ViewController ()

@end

@implementation ViewController
{
//
//
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSData *data = [NSData data];
    NSDictionary *dic = @{@"name": @"jack", @"idNum":@20130312, @"imgData":data};
//    ItemModel *model1 = [[ItemModel alloc] initWithDataDic:dic];
//    dic = @{@"name": @"jack", @"idNum":@20130312, @"imgData":data};
//    ItemModel *model2 = [[ItemModel alloc] initWithDataDic:dic];
//    NSArray *array = @[model1,model2];
//    [Tools archiver:array];
    
    NSArray *result = [Tools unArchiver];
    ItemModel *model3 = result[0];
    NSLog(@"%@ -- %@ -- %@", model3.name, model3.idNum, model3.imgData);
    
}

-(NSString *)filePath
{
    return @"/Users/issuser/Desktop/music/texts";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
