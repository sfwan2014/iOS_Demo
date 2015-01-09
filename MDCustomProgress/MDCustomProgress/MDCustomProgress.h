//
//  MDCustomProgress.h
//  MDCustomProgress
//
//  Created by sfwan on 14-12-18.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDCustomProgress : UIView
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;

-(id)initWithFrame:(CGRect)frame normalColor:(UIColor *)norColor highlightColor:(UIColor *)highlightColor;
-(void)setProgress:(CGFloat)progress animation:(BOOL)animation;

@end
