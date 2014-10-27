//
//  ItemView.m
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ItemView.h"

#define kAnimationDuration          0.31

@implementation ItemView
{
    UILabel *label;
    kOperatorType _type;
    id _target;
    SEL _selector;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    self.layer.cornerRadius = self.frame.size.width/2.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor orangeColor];
    
    label = [[UILabel alloc] initWithFrame:self.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:8];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor purpleColor];
    [self addSubview:label];
}

-(void)_addAnimation
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint originalPoint = self.center;
    [path moveToPoint:originalPoint];
    [path addLineToPoint:_currentPosition];
    CAKeyframeAnimation *posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = path.CGPath;
    posAnim.duration = kAnimationDuration;
    posAnim.removedOnCompletion = YES;
    posAnim.delegate = self;
    
    NSString *key = _type == kOperatorTypeShow? @"show":@"hide";
    posAnim.values = @[key];
    
    [self.layer addAnimation:posAnim forKey:nil];
}

-(void)setCurrentPosition:(CGPoint)currentPosition
{
    [self setCurrentPosition:currentPosition animation:NO operator:kOperatorTypeShow];
}

-(void)setCurrentPosition:(CGPoint)currentPosition animation:(BOOL)animation operator:(kOperatorType)type
{
    _type = type;
    currentPosition.x = currentPosition.x + self.frame.size.width/2.0;
    currentPosition.y = currentPosition.y + self.frame.size.height/2.0;
    _currentPosition = currentPosition;
    
    if (animation) {
        [self _addAnimation];
    }
    
    self.center = currentPosition;
}

-(void)setItem:(CustomItem *)item
{
    _item = item;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    label.text = _item.title;
}

#pragma mark - touch event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendAction:_selector to:_target forEvent:event];
}

- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag
{
    if ([anim.values[0] isEqualToString:@"hide"]) {
        [self removeFromSuperview];
    }
}

-(void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _selector = action;
}

@end
