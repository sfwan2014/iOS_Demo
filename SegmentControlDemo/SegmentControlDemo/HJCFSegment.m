//
//  HJCFSegment.m
//  SegmentControlDemo
//
//  Created by sfwan on 14-7-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFSegment.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kItemHeight     30

#define kDefaultFontSize    20.0

@implementation HJCFSegment
{
    NSMutableArray *_itemViews;
    NSMutableArray *_labels;
    id _target;
    SEL _selector;
    CGPoint _startPosition;
    
    UIColor *_norTextColor;
    UIColor *_selTextColor;
}

- (id)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
        _selectedColor = [UIColor whiteColor];
        _normalColor = [UIColor grayColor];
        _highlightColor = nil;//[UIColor blackColor];
        
        _norTextColor = _selectedColor;
        _selTextColor = _normalColor;
        
//        self.frame = CGRectMake(0, 0, kScreenWidth, kItemHeight);
        
        CGFloat width = kScreenWidth/items.count;
        _itemViews = [NSMutableArray arrayWithCapacity:items.count];
        _labels = [NSMutableArray arrayWithCapacity:items.count];
        for (int i = 0; i < items.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, width, kItemHeight)];
            view.backgroundColor = [UIColor darkGrayColor];
            [_itemViews addObject:view];
            [self addSubview:view];
            
            NSString *title = items[i];
            UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:kDefaultFontSize];
            label.textColor = [UIColor whiteColor];
            label.text = title;
            [self addSubview:label];
            [_labels addObject:label];
        }
        
        self.selectIndex = 0;
    }
    
    return self;
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    for (int i = 0; i < _itemViews.count; i++) {
        UIView *view = [_itemViews objectAtIndex:i];
        UILabel *label = _labels[i];
        if (i == _selectIndex) {
            view.backgroundColor = self.selectedColor;
            label.textColor = _selTextColor;
        } else {
            view.backgroundColor = self.normalColor;
            label.textColor = _norTextColor;
        }
        
    }
}

-(void)layoutSubviews
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = kScreenWidth/_itemViews.count;
    UITouch *touch = [touches anyObject];
    _startPosition = [touch locationInView:self];
    NSInteger index = _startPosition.x/width;
    
    UIView *view = _itemViews[index];
    if (_highlightColor != nil) {
        view.backgroundColor = _highlightColor;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = kScreenWidth/_itemViews.count;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!CGPointEqualToPoint(_startPosition, point)) {
        return;
    }
    
    NSInteger index = point.x/width;
    self.selectIndex = index;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self sendAction:_selector to:_target forEvent:event];
}

@end
