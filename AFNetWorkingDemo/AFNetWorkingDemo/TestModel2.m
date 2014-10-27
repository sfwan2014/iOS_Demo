//
//  TestModel2.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "TestModel2.h"


@implementation TestModel2

@dynamic uID;
@dynamic summary;
@dynamic price;

- (id)setMapAttributes
{
    NSDictionary *dic = @{@"summary":@"summary", @"price":@"price", @"uID":@"id"};
    return dic;
} // 防止出现警告

@end
