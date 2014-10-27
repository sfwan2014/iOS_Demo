//
//  LineChartView.m
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ChartCoordinateView.h"

#define kSpaceWidth     40
#define kMinLineWidth   5

@implementation ChartCoordinateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.lineWidth = 1.0;
        self.lineColor = [UIColor blackColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSString *rowTitle = [self getRowTitle];
    NSString *columnTitle = [self getColumnTitle];
    
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSaveGState(context);
    
    // 画列标题
    CGPoint point = CGPointZero;
    CGSize size = [self textSize:columnTitle font:[UIFont systemFontOfSize:7]];
    [columnTitle drawAtPoint:point withAttributes:[self textAttributes]];
    
    // 画行间距
    NSInteger rows = [self getRows];
    NSInteger columns = [self getColumns];
    CGFloat rowHeight = (self.frame.size.height - kSpaceWidth)/(rows);
    CGFloat columnHeight = (self.frame.size.width - kSpaceWidth)/columns;
    
    point = CGPointMake(kSpaceWidth/2.0, kSpaceWidth/2.0);
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    // 行
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGPoint p = CGPointMake(point.x, point.y);
    for (int i = rows - 1; i >= 0; i--) {
        CGContextBeginPath(context);
        p.x = kSpaceWidth/2.0;
        
        CGContextSaveGState(context);
        NSString *subTitle = [self getSubRowTitles:i];
        CGSize size = [self textSize:subTitle font:[UIFont systemFontOfSize:7]];
        [subTitle drawAtPoint:CGPointMake(size.width/2.0, p.y-size.height/2.0) withAttributes:[self textAttributes]];
        CGContextRestoreGState(context);
        
        CGContextMoveToPoint(context, p.x, p.y);
        p.x = p.x + kMinLineWidth;
        CGContextAddLineToPoint(context, p.x, p.y);
        p.y = rowHeight + p.y;
        CGContextStrokePath(context);
    }
    
    // 列
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 1);
    p = CGPointMake(kSpaceWidth/2.0+columnHeight, point.y);
    for (int i = 0; i < columns; i++) {
        p.y = self.frame.size.height - kSpaceWidth/2.0;
        
        NSString *subTitle = [self getSubColumnTitles:i];
        CGSize size = [self textSize:subTitle font:[UIFont systemFontOfSize:7]];
        CGContextSaveGState(context);
        [subTitle drawAtPoint:CGPointMake(p.x - size.width/2.0, p.y +size.height/2.0) withAttributes:[self textAttributes]];
        CGContextRestoreGState(context);
        
        CGContextMoveToPoint(context, p.x, p.y);
        p.y = p.y - kMinLineWidth;
        CGContextAddLineToPoint(context, p.x, p.y);
        p.x = p.x + columnHeight;
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    
    CGContextMoveToPoint(context, point.x, point.y);
    
    point = CGPointMake(kSpaceWidth/2.0, self.frame.size.height - kSpaceWidth/2.0);
    CGContextAddLineToPoint(context, point.x, point.y);
    
    point = CGPointMake(self.frame.size.width - kSpaceWidth/2.0, self.frame.size.height - kSpaceWidth/2.0);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathStroke);
    
    size = [self textSize:rowTitle font:[UIFont systemFontOfSize:7]];
    point.x = point.x - size.width;
    [rowTitle drawAtPoint:point withAttributes:[self textAttributes]];
}


// 获取数据源代理数据
-(NSInteger)getColumns
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewColumns:)]) {
        return [self.dataSource chartCoordinateViewColumns:self];
    }
    return 0;
}

-(NSInteger)getRows
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewRows:)]) {
        return [self.dataSource chartCoordinateViewRows:self];
    }
    return 0;
}

-(NSString *)getColumnTitle
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewColumnsTitle:)]) {
        return [self.dataSource chartCoordinateViewColumnsTitle:self];
    }
    return nil;
}

-(NSString *)getRowTitle
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewRowTitle:)]) {
        return [self.dataSource chartCoordinateViewRowTitle:self];
    }
    return nil;
}

-(NSString *)getSubRowTitles:(NSInteger)row
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewRowSubTitle:inRow:)]) {
        return [self.dataSource chartCoordinateViewRowSubTitle:self inRow:row];
    }

    return nil;
}

-(NSString *)getSubColumnTitles:(NSInteger)column
{
    if ([self.dataSource respondsToSelector:@selector(chartCoordinateViewColumnsSubTitle:inColumn:)]) {
        return [self.dataSource chartCoordinateViewColumnsSubTitle:self inColumn:column];
    }
    
    return nil;
}


-(NSDictionary *)textAttributes
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:7], NSStrokeColorAttributeName:[UIColor orangeColor], NSForegroundColorAttributeName:[UIColor blueColor]};
    
    return dic;
}

-(CGSize)textSize:(NSString *)text font:(UIFont *)font
{
    return [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, 20)];
}

@end
