//
//  HJCFXibView.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFXibView.h"

@implementation HJCFXibView
+(id)loadFromNib
{
    NSString *nibName = NSStringFromClass(self);
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    return view;
}

@end
