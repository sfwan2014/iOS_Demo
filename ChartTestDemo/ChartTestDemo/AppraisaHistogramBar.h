//
//  SimpleHistogramBar.h
//  FinancialIPAD
//
//  Created by zsc on 13-12-30.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define kHelveticaNeue  @"Helvetica Neue"
#define RGBA_Color(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface AppraisaHistogramBar : CALayer<NSCopying>

@property (nonatomic, retain) UIColor *cloumnBorderColor;   //柱边颜色；
@property (nonatomic, retain) UIColor *cloumnFillColor;     //柱的颜色；
@property (nonatomic, assign) CGFloat barHeight;
/**
 *  柱状图的单个柱形条； 功能：从起点到终点的动画，并显示自己的值；
 **/
- (id)initWithFrame:(CGRect)frame  andbgColor:(CGColorRef)color;

-(void)setHeight:(float)barHeigth andAnimationDuration:(float)duration  andDelay:(float)delay andTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor*)titleColor;
-(CGFloat)barHeight;


@end
