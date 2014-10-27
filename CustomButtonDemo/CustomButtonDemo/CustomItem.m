//
//  CustomItem.m
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomItem.h"

@implementation CustomItem
{
    NSString *_title;
    NSInteger _tag;
}

-(id)initWithTitle:(NSString *)title tag:(NSInteger)tag
{
    self = [self init];
    if (self) {
        _title = title;
        _tag = tag;
    }
    
    return self;
}

@end
