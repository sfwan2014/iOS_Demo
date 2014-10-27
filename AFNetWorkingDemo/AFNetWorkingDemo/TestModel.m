//
//  TestModel.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "TestModel.h"


@implementation TestModel

@dynamic subtitle;
@dynamic author;
@dynamic alt;
@dynamic pubdate;
@dynamic uID;
@dynamic tags;

- (id)setMapAttributes
{
    NSDictionary *dic = @{@"subtitle":@"subtitle", @"author":@"author", @"alt":@"alt", @"pubdate":@"pubdate", @"uID":@"id", @"tags":@"tags"};
    return dic;
} // 防止出现警告

@end
