//
//  SwipeView.h
//  SwipeImageViewDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface SwipeView : UIView
@property (nonatomic, strong) NSArray *items;

- (id)initWithFrame:(CGRect)frame  items:(NSArray *)items;

@end