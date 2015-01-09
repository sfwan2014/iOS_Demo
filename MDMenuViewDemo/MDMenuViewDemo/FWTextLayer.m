//
//  FWTextLayer.m
//  FinancialIPAD
//
//  Created by Edmond on 11/1/13.
//  Copyright (c) 2013 CYTX. All rights reserved.
//

#import "FWTextLayer.h"
#import "CATextLayer+AutoSizing.h"

@implementation FWTextLayer

@synthesize shadowColor = _shadowColor;
@synthesize labelColor = _labelColor;

//  初始化基本参数；
- (id)init
{
    if (self = [super init]) {
        self.contentsScale = [UIScreen mainScreen].scale;
//        self.anchorPoint = POINT(0, 0);
        self.alignmentMode = kCAAlignmentCenter;
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.foregroundColor = _labelColor.CGColor;
    
    }
    return self;
}

- (void)setTextFont:(UIFont *)font
{
    CGFontRef fontContex = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) {
        fontContex = CGFontCreateCopyWithVariations((__bridge CGFontRef)(font),
                                                    (__bridge CFDictionaryRef)@{});
    }else{
        fontContex = CGFontCreateWithFontName((__bridge CFStringRef)[font fontName]);
    }
    
    if (fontContex) {
        [self setFont:fontContex];
        CFRelease(fontContex);
    }
    
    self.fontSize = font.pointSize;
    
}

- (void)setTextFont:(UIFont *)font text:(NSString *)text
{
    [self setTextFont:font];
    [self setString:text];
    
    CGSize size = [text sizeWithFont:font];
    [self setBounds:CGRectMake(0, 0, size.width, size.height)];
}

- (void)setTextFont:(UIFont *)font text:(NSString *)text position:(CGPoint)position
{
    [self setTextFont:font text:text];
    
    self.position = position;
    [self adjustBoundsToFit];
}

- (void)setTextShadow
{
    self.shadowOffset = CGSizeMake(3, 3);
    self.shadowOpacity = 0.8f;
    self.shadowRadius = 3.0f;
}

- (void)setYDirectionAnimationWithCurrentPoint:(CGPoint)currentPoint
{
    CGPoint center = CGPointMake(CGRectGetMinX(self.frame) + CGRectGetWidth(self.frame)/2,
                                 CGRectGetMinY(self.frame) + CGRectGetHeight(self.frame)/2);
    
    
    float xPad = abs (currentPoint.x - center.x);
    
    
    //  check if the layer should begin to move;
    //    xPad = xPad > 0 ? xPad : -xPad;
    
    xPad = xPad > _maxDeflat ? _maxDeflat : xPad;
    
    
    //  detach how the pad to move;
    
    
    
    
    CABasicAnimation *movingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    movingAnimation.duration = 1.0;
    movingAnimation.autoreverses = YES;
    movingAnimation.fromValue = [NSNumber numberWithInteger:0];
    movingAnimation.toValue = [NSNumber numberWithInteger: - xPad];
    movingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self addAnimation:movingAnimation forKey:@"TextLayerMovingAnimation"];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.0;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fromValue = [NSNumber numberWithInteger:1];
    scaleAnimation.toValue = [NSNumber numberWithInteger:1.5];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self addAnimation:scaleAnimation forKey:@"TextLayerScaleAnimation"];
    
}




@end
