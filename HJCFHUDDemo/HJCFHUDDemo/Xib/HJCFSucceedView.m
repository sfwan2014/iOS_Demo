//
//  HJCFSucceedView.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFSucceedView.h"

@implementation HJCFSucceedView

+(id)loadFromNib
{
    UIView *view = [super loadFromNib];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    
    return view;
}

@end
