//
//  ItemView.h
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomItem.h"

typedef enum : NSUInteger {
    kOperatorTypeShow = 1,
    kOperatorTypeHide,
} kOperatorType;

@interface ItemView : UIControl

@property (nonatomic, strong) CustomItem *item;

@property (nonatomic, assign)CGPoint currentPosition;

-(void)setCurrentPosition:(CGPoint)currentPosition animation:(BOOL)animation operator:(kOperatorType)type;

-(void)addTarget:(id)target action:(SEL)action;

@end
