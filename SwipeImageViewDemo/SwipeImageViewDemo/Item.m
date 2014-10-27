//
//  Item.m
//  SwipeImageViewDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "Item.h"

@implementation Item
- (NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"(\n imageName=%@\n other=%@ \n index=%d \n)", _imageName, _other, _index];
    return description;
}
@end
