//
//  VirtualHistogramBar.h
//  ChartTestDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#define kHelveticaNeue  @"Helvetica Neue"
#define RGBA_Color(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface AppraisaVirtualHistogramBar : CALayer
/**
 *  柱状图的单个柱形条； 功能：从起点到终点的动画，并显示自己的值；
 **/
- (id)initWithFrame:(CGRect)frame  andbgColor:(CGColorRef)color;

-(void)setHeight:(float)barHeigth andAnimationDuration:(float)duration  andDelay:(float)delay andTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor*)titleColor;
@end
