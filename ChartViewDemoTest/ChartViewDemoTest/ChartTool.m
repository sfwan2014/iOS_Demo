//
//  ChartTool.m
//  ChartViewDemoTest
//
//  Created by sfwan on 14-10-19.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ChartTool.h"
#define kOriginalX          50

@implementation ChartTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(CGPoint)axisOriginal:(CGRect)rect
{
    CGPoint point;
    CGFloat height = rect.size.height;
//    CGFloat width = rect.size.width;
    
    point.y = 4 * height/5;
    point.x = kOriginalX;
    return point;
}

// 画虚线
+(void)setDrawLineDash:(CGContextRef)context
{
    CGFloat lengths[] = {2, 1};
    CGContextSetLineDash(context, 0, lengths, 2);
}
//
+(CGPoint)AxisXTextPoint:(CGPoint)referPoint
{
    CGPoint point = CGPointMake(referPoint.x, referPoint.y + 10);
    
    return point;
}

+(CGPoint)AxisYTextPoint:(CGPoint)referPoint
{
    CGPoint point = CGPointMake(referPoint.x-20, referPoint.y - 5);
    
    return point;
}

+(void)drawText:(NSString *)text point:(CGPoint)point textColor:(UIColor *)color textFont:(UIFont *)font
{
    NSDictionary *attribute = @{UITextAttributeTextColor:color, UITextAttributeFont:font};
    [text drawAtPoint:point withAttributes:attribute];
}


// 原点平行于X坐标点
+(CGPoint)startHorizontalAxisPoint:(NSInteger)colum rect:(CGRect)rect
{
    CGPoint startPoint = [ChartTool axisOriginal:rect];
    startPoint.x = startPoint.x + colum * self.horizontalSpace;
    return startPoint;
}
// 原点垂直于X坐标点
+(CGPoint)startVerticalAxisPoint:(NSInteger)row rect:(CGRect)rect
{
    CGPoint startPoint = [ChartTool axisOriginal:rect];
    startPoint.y = startPoint.y - row * self.verticalSpace;
    return startPoint;
}

+(CGFloat)horizontalSpace
{
    return 60;
}

+(CGFloat)verticalSpace
{
    return 12;
}

+(CGFloat)lineHeight:(NSInteger)count
{
    return self.verticalSpace * count;
}

// 画线
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor
{
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}

// 画线
+ (void)drawLines:(CGContextRef)context points:(CGPoint *)points lineColor:(UIColor *)lineColor
{
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    NSLog(@"%lu", sizeof(points));
//    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLines(context, points, sizeof(points)+1);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}

// 画点
+ (void)drawPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Pointcolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Pointcolorspace1);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, point.x,point.y);
    CGContextAddArc(context, point.x, point.y, 2, 0, 360, 0);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGColorSpaceRelease(Pointcolorspace1);
}

+(CGPoint)pointWithValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue colunm:(NSInteger)colunm rect:(CGRect)rect count:(NSInteger)count
{
    CGPoint original = [self startHorizontalAxisPoint:colunm rect:rect];
    CGFloat height = [self heightWithValue:value minValue:minValue maxValue:maxValue rect:rect count:count];
    CGPoint point = CGPointMake(original.x, rect.size.height - height - rect.size.height/5.0);
    
    return point;
}

+ (CGFloat)heightWithValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue rect:(CGRect)rect count:(NSInteger)count
{
    CGFloat height;
    CGFloat percentage = value / maxValue;
    CGFloat h = [ChartTool lineHeight:count];
    
    height = h * percentage;
    
    return height;
}

@end
