//
//  VirtualHistogramBar.m
//  ChartTestDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "AppraisaVirtualHistogramBar.h"
#import "FWTextLayer.h"
#import "StringHelper.h"

@implementation AppraisaVirtualHistogramBar
{
    float _vheight;
    float _animationDuration;
    float _animationDelay;
    NSString * _title;
    UIFont * _titleFont;
    UIColor *_titleColor;
}
- (id)initWithFrame:(CGRect)frame andbgColor:(CGColorRef)color{
    self = [super init];
    
    if (self) {
        self.frame=frame;
        //        _vheight=-frame.size.height;
        self.backgroundColor=color;
        self.borderColor=color;
        self.borderWidth=1.0f;
    }
    
    return self;
}

-(void)setCloumnBorderColor:(UIColor *)cloumnBorderColor{
    
    self.borderColor = cloumnBorderColor.CGColor;
}

-(void)setCloumnFillColor:(UIColor *)cloumnFillColor{
    self.backgroundColor = cloumnFillColor.CGColor;
}


-(void)setHeight:(float)barHeigth andAnimationDuration:(float)duration  andDelay:(float)delay andTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor*)titleColor{
    _vheight=-barHeigth;
    _animationDelay=delay;
    _animationDuration=duration;
    
    _title=title;
    _titleFont=font;
    
    [self drawTitle:title andTitleFont:font andTitleColor:titleColor];
}

- (void)cloumeMoveToValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    [animation setValue:@"kSimpleHistogramBarCABasicAnimation" forKey:@"id"];
    animation.delegate=self;
    animation.duration = _animationDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion=NO;
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _vheight);
    
    [self addAnimation:animation forKey:@"kSimpleHistogramBarCABasicAnimation"];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag==YES && [[anim valueForKey:@"id"] isEqualToString:@"kSimpleHistogramBarCABasicAnimation"] ) {
        [self drawTitle:_title andTitleFont:_titleFont andTitleColor:nil];
    }
}

-(void)drawTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor*)titleColor{
    UIFont *titleFont;
    UIColor *tColor;
    if (font==nil) {
        titleFont= [UIFont fontWithName:kHelveticaNeue size:12.0f];
    }
    else{
        titleFont=font;
    }
    if (titleColor==nil) {
        tColor=RGBA_Color(173, 173, 173, 1.0);
    }
    else{
        tColor=titleColor;
    }
    CGSize titleSize = [StringHelper getTextSize:title withFont:titleFont];
    
    FWTextLayer *layer = [FWTextLayer layer];
    
    layer.foregroundColor = tColor.CGColor;
    
    float y;
    if (titleSize.width< self.frame.size.width && titleSize.height<( self.frame.size.height +5)) {
        y =  fabsf(_vheight)  - titleSize.height;
    }else{
        y =  fabsf(_vheight)   + titleSize.height;
    }
    
    //    y = self.frame.size.height-y;
    y = self.frame.size.height - titleSize.height;
    
    [layer setTextFont:titleFont text:title position:CGPointMake(self.frame.size.width/2.0, y)];
    
    [self addSublayer:layer];
}
@end
