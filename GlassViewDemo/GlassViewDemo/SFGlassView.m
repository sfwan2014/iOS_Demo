//
//  SFGlassView.m
//  GlassViewDemo
//
//  Created by sfwan on 14-7-18.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SFGlassView.h"

@implementation SFGlassView
{
    UILabel *label;
    CAShapeLayer *_contentLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    test.textColor = [UIColor redColor];
    test.backgroundColor = [UIColor clearColor];
    test.textAlignment = NSTextAlignmentCenter;
    test.font = [UIFont systemFontOfSize:15];
    test.text = @"哈哈哈哈哈";
    [self addSubview:test];
    
    _contentLayer = [CAShapeLayer new];
    _contentLayer.frame = self.bounds;
    _contentLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _contentLayer.opacity = 0.9;
    
    [self.layer addSublayer:_contentLayer];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [_contentLayer addSublayer:label.layer];
//    label.text = @"你看不到我";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
}

-(void)setOpacity:(CGFloat)opacity
{
    _opacity = opacity;
    _contentLayer.opacity = opacity;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
