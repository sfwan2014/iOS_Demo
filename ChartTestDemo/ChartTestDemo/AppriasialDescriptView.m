//
//  AppriasialDescriptView.m
//  ChartTestDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "AppriasialDescriptView.h"
#import "DescriptLayer.h"

@implementation AppriasialDescriptView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat reusedHeight = [self drawHead];
    
    [self drawContext:reusedHeight];
}

-(CGFloat)drawHead{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画文字
    NSString *text = @"米多推荐";
    NSDictionary *attributes = @{UITextAttributeFont:[UIFont systemFontOfSize:12]};
    
    CGSize size = [text sizeWithAttributes:attributes];
    
    [text drawAtPoint:CGPointMake((self.frame.size.width-size.width)/2.0, size.height/2) withAttributes:attributes];
    
    // 画左边线
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 0.1);
    CGContextMoveToPoint(context, 5, size.height);
    CGContextAddLineToPoint(context, (self.frame.size.width-70)/2.0, size.height);
    CGContextStrokePath(context);
    
    // 画右边线
    CGContextMoveToPoint(context, (self.frame.size.width-70)/2.0 + 70, size.height);
    CGContextAddLineToPoint(context, self.frame.size.width-5, size.height);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    return size.height;
}

-(void)drawContext:(CGFloat)space{
    CGFloat height = (self.frame.size.height - space) / _data.count;
    
    _desLayers = [NSMutableArray array];
    for (int i = 0; i < _data.count; i++) {
        DescriptLayer *layer =[[ DescriptLayer alloc] initWithFrame:CGRectMake(0, height * i+ space, self.frame.size.width, height) color:[UIColor blackColor].CGColor font:[UIFont systemFontOfSize:12]];
        [self.layer addSublayer:layer];
        
        [layer addMessages:_data[i]];
        [_desLayers addObject:layer];
    }
}

@end
