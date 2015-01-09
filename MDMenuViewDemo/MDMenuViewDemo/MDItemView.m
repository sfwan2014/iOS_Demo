//
//  MDItemView.m
//  MDMenuViewDemo
//
//  Created by sfwan on 14-12-24.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDItemView.h"

#define kLineWidth      1

@interface MDItemView ()
@property (nonatomic, strong) UIBezierPath *path;
@end

@implementation MDItemView{
    UILabel *titleLabel;
    UIEdgeInsets edge;
    BOOL _touchBegin;
}

-(id)initWithFrame:(CGRect)frame title:(NSString *)title normalColor:(UIColor *)nColor selectedColor:(UIColor *)sColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.selectedColor = sColor;
        self.normalColor = nColor;
        _touchBegin = NO;
        self.backgroundColor = [UIColor clearColor];
        edge = UIEdgeInsetsMake(5, 5, 5, 5);
        
        [self createContentLabel];
    }
    return self;
}

-(void)createContentLabel{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(edge.left, edge.top, self.frame.size.width-edge.left-edge.right, self.frame.size.height-edge.top-edge.bottom)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:titleLabel];
}

-(void)drawRect:(CGRect)rect{
    
    if (self.normalColor == nil) {
        self.normalColor = [UIColor whiteColor];
    }
    
    if (self.selectedColor == nil) {
        self.selectedColor = [UIColor purpleColor];
    }
    
    CGRect rect1 = CGRectMake(rect.origin.x+kLineWidth, rect.origin.y+kLineWidth, rect.size.width - kLineWidth * 2, rect.size.height - kLineWidth * 2);
    _path = [UIBezierPath bezierPathWithOvalInRect:rect1];
    [_path setLineWidth:kLineWidth];
    [_path closePath];
    if (self.selected) {
        [self.selectedColor set];
        [_path fill];
    } else {
        [self.normalColor set];
        [_path stroke];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    titleLabel.text = _title;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    _touchBegin = YES;
    if (![self.path containsPoint:p]) {
        _touchBegin = NO;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchBegin) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    }
}

@end
