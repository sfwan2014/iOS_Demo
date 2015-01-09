//
//  SimpleHistogramBar.m
//  FinancialIPAD
//
//  Created by zsc on 13-12-30.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import "AppraisaHistogramBar.h"
#import "FWTextLayer.h"
#import "StringHelper.h"


@implementation AppraisaHistogramBar
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
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
//        _vheight=-frame.size.height;
        self.backgroundColor=color;
        self.borderColor=color;
        self.borderWidth=1.0f;
    }
    
    return self;
}

-(void)setHeight:(float)barHeigth andAnimationDuration:(float)duration  andDelay:(float)delay andTitle:(NSString *)title andTitleFont:(UIFont *)font andTitleColor:(UIColor*)titleColor{
    _barHeight = barHeigth;
    _vheight=-barHeigth;
    _animationDelay=delay;
    _animationDuration=duration;
    _titleColor = [UIColor whiteColor];
    _title=title;
    _titleFont=font;
 
    [self performSelector:@selector(cloumeMoveToValue) withObject:self afterDelay:_animationDelay];
    
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
        [self drawTitle:_title andTitleFont:_titleFont andTitleColor:_titleColor];
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
