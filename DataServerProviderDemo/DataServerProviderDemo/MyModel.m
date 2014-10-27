//
//  MyModel.m
//  DataServerProviderDemo
//
//  Created by sfwan on 14-7-2.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MyModel.h"


@implementation MyModel

@dynamic price;
@dynamic summary;
@dynamic uID;

- (id)setMapAttributes
{
    return @{@"price":@"price", @"summary":@"summary", @"uID":@"id"};
}

@end
