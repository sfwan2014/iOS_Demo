//
//  BaseView.m
//  CustomGroupTableView
//
//  Created by sfwan on 14-10-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

+(NSString *)nibName
{
    return NSStringFromClass(self);
}

+(BaseView *)loadFormXib
{
    return [[[NSBundle mainBundle] loadNibNamed:[self nibName] owner:nil options:nil] lastObject];
}

@end
