//
//  DescriptLayer.m
//  ChartTestDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "DescriptLayer.h"
#import "FWTextLayer.h"

@implementation DescriptLayer{
    NSString *_title;
    NSString *_percent;
    NSArray  *_products;
    
    CGColorRef _color;
    UIFont *_font;
    
    FWTextLayer *_titleLayer;
    FWTextLayer *_percentLayer;
}

-(id)initWithFrame:(CGRect)frame color:(CGColorRef )color font:(UIFont *)font{
    self = [super init];
    if (self) {
        self.frame = frame;
        _color = color;
        _font = font;
        CALayer *pointLayer = [[CALayer alloc] init];
        pointLayer.frame = CGRectMake(0, 0, 5, 5);
        pointLayer.backgroundColor = _color;
        pointLayer.position = CGPointMake(5, frame.size.height/2);
        [self addSublayer:pointLayer];
        
        pointLayer.cornerRadius = 5/2.0;
        pointLayer.masksToBounds = YES;
    }
    return self;
}

-(void)addMessages:(NSMutableDictionary *)message{
    _title = [message objectForKey:@"title"];
    _percent = [message objectForKey:@"percent"];
    _products = [message objectForKey:@"product"];
    
    CGFloat width = self.frame.size.width/4;
    
    _titleLayer = [[FWTextLayer alloc] init];
    _titleLayer.foregroundColor = _color;
    CGPoint position = CGPointMake(0 + width/2, self.frame.size.height/2.0);
    [_titleLayer setTextFont:_font text:_title position:position];
    [self addSublayer:_titleLayer];
    
    for (int i = 0; i < _products.count; i++) {
        NSString *product = _products[i];
        position = CGPointMake(width * (i+1) + width/2, self.frame.size.height/2.0);
        FWTextLayer *layer = [[FWTextLayer alloc] init];
        layer.foregroundColor = _color;
        [layer setTextFont:_font text:product position:position];
        [self addSublayer:layer];
    }
    
    position = CGPointMake(width*3 + width/2, self.frame.size.height/2.0);
    _percentLayer = [[FWTextLayer alloc] init];
    [_percentLayer setTextFont:_font text:_percent position:position];
    _percentLayer.foregroundColor = _color;
    [self addSublayer:_percentLayer];
}

@end
