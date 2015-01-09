//
//  MDItemView.h
//  MDMenuViewDemo
//
//  Created by sfwan on 14-12-24.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDItemView : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
//@property (nonatomic, assign) BOOL selected;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title normalColor:(UIColor *)nColor selectedColor:(UIColor *)sColor;
@end
