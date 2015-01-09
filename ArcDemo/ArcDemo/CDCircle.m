//
//  MDCircle.m
//  ArcDemo
//
//  Created by sfwan on 14-12-21.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "CDCircle.h"
#import "CDCircleThumb.h"
#import "CDCircleGestureRecognizer.h"
#import "CDCircleThumb.h"
#import "CDCircleOverlayView.h"

@implementation CDCircle{
    NSArray *_data;
    NSMutableArray *_thumbs;
    NSArray *_fillColors;
}

-(id)initWithFrame:(CGRect)frame Data:(NSArray *)data fillColors:(NSArray *)fillColors ringWidth:(CGFloat)ringWidth{
    self = [super initWithFrame:frame];
    if (self) {
        _data = data;
        _ringWidth = ringWidth;
        _fillColors = fillColors;
        [self createThumbs];
        self.recognizer = [[CDCircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)createThumbs{
    _thumbs = [NSMutableArray array];
    
    for (int i = 0; i < _data.count; i++) {
        
        CGFloat width = MIN(self.frame.size.width, self.frame.size.height);
        CGFloat lRadius = width/2;
        self.radius = width/2;
        CGFloat sRadius = lRadius - self.ringWidth;
        CGFloat rate = [_data[i] floatValue];
        
        UIColor *fillColor = [UIColor redColor];
        if (_fillColors.count == _data.count) {
            fillColor = _fillColors[i];
        }
        
        CDCircleThumb *thumb = [[CDCircleThumb alloc] initWithShortCircleRadius:sRadius longRadius:lRadius fillColor:fillColor strokeColor:nil rate:rate];
        [_thumbs addObject:thumb];
    }
}

-(void)drawRect:(CGRect)rect{
    CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2*_ringWidth), CGRectGetWidth(rect) - (2*_ringWidth));
    rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
    rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;
    
    //Drawing Thumbs
//    CGFloat fNumberOfSegments = _data.count;
    
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat totalRotation = 0;//kRotationDegrees;
    CGFloat deltaAngle = 0.0;
    
    
    for (int i = 0; i < _data.count; i++) {
        CDCircleThumb * thumb = [_thumbs objectAtIndex:i];
        thumb.tag = i;
        thumb.layer.position = centerPoint;
        thumb.layer.position = centerPoint;
        [self addSubview:thumb];
        
        if (i==0) {
            CGFloat rate = [_data[0] floatValue];
            CGFloat angle = rate * 360;
//            thumb.transform = CGAffineTransformMakeRotation(degreesToRadians(totalRotation));
            deltaAngle= degreesToRadians(-angle/2) + atan2(thumb.transform.a, thumb.transform.b);
            self.recognizer.currentThumb = thumb;
        }
    }
    
    for (int i = 1; i < _data.count; i++) {
        
        CGFloat rate = [_data[i-1] floatValue];
        CGFloat angle = rate * 360;//108 72 108 72
        CGFloat perSectionDegrees = angle + totalRotation;
        
        CDCircleThumb * thumb = [_thumbs objectAtIndex:i];
        thumb.tag = i;
        
        [thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians(perSectionDegrees))];
        
        totalRotation += angle;
    }
    
    [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
}


-(void) tapped: (CDCircleGestureRecognizer *) arecognizer{
    if (arecognizer.ended == NO) {
        CGPoint point = [arecognizer locationInView:self];
        if ([_path containsPoint:point] == NO) {
            if ([self.delegate respondsToSelector:@selector(circle:Move:)]) {
                BOOL move = [self.delegate circle:self Move:[arecognizer rotation]];
                if (move) {
                    [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
                } else {
                    arecognizer.state = UIGestureRecognizerStateFailed;
                }
            }
            
        }
    }
}


@end
