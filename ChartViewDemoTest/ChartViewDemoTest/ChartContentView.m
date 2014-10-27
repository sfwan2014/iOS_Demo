//
//  ChartContentView.m
//  ChartViewDemoTest
//
//  Created by sfwan on 14-10-19.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ChartContentView.h"
#import "ChartTool.h"

@interface ChartContentView()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ChartContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [self initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.dataSource.count; i++) {
        UIColor *color = self.colors[i];
        [self drawPoint:context inRect:rect points:self.dataSource[i] color:color];
        [self drawLine:context inRect:rect points:self.dataSource[i] color:color];
    }
}

-(NSArray *)colors{
    return @[[UIColor orangeColor], [UIColor blueColor]];
}

-(void)drawPoint:(CGContextRef)context inRect:(CGRect)rect points:(NSArray *)points color:(UIColor *)color
{
    for (int i = 0; i < points.count; i++) {
        CGFloat value = [points[i] floatValue];
        CGPoint point = [ChartTool pointWithValue:value minValue:500 maxValue:3000 colunm:i rect:rect count:6];
        
        [ChartTool drawPoint:context point:point color:color];
    }
}

-(void)drawLine:(CGContextRef)context inRect:(CGRect)rect points:(NSArray *)points color:(UIColor *)color
{
    CGPoint *_points = malloc(points.count * sizeof(CGPoint));
    for (int i = 0; i < points.count; i++) {
        CGFloat value = [points[i] floatValue];
        CGPoint point = [ChartTool pointWithValue:value minValue:500 maxValue:3000 colunm:i rect:rect count:6];
        _points[i] = point;
    }
    [ChartTool drawLines:context points:_points lineColor:color];
}

@end
