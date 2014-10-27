//
//  CustomButton.m
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomButton.h"
#import "CustomItem.h"
#import "ItemView.h"

#define kSpaceGap       3

@implementation CustomButton
{
    NSMutableArray *_items;
    id _target;
    SEL _selector;
    UIView *showView;
    
    CGPoint _originalPosition;
}

-(id)initWithFrame:(CGRect)frame items:(NSArray *)items target:(id)target selector:(SEL)selector
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
        
        _target = target;
        _selector = selector;
        
        NSInteger count = items.count;
        CGFloat height = (kItemWidth + (count -1) * kSpaceGap) * (count + 1);
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        
        for (int i = 0; i < count; i++) {
            NSString *title = items[i];
            CustomItem *item = [[CustomItem alloc] initWithTitle:title tag:i];
            ItemView *view = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth)];
            view.backgroundColor = [UIColor orangeColor];
            view.item = item;
            [view addTarget:self action:@selector(itemClickAction:)];
            
            [_items addObject:view];
        }
    }
    
    return self;
}

-(void)itemClickAction:(ItemView *)view
{
    NSLog(@"%s %@", __FUNCTION__, view.item.title);
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];
}

-(void)_initView
{
    _items = [[NSMutableArray alloc] init];
    
    self.layer.cornerRadius = self.frame.size.width/2.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    showView = [[UIView alloc] initWithFrame:self.bounds];
    showView.backgroundColor = [UIColor greenColor];
    [self addSubview:showView];
    showView.layer.cornerRadius = self.frame.size.width/2.0;
    showView.layer.masksToBounds = YES;
    showView.layer.borderColor = [UIColor redColor].CGColor;
    showView.layer.borderWidth = 1.0;
    showView.layer.masksToBounds = YES;
}

-(void)_layoutSubViews
{
    if (self.selected) {
        // 展开
        if (_items.count > 0) {
            NSInteger count = _items.count;
            CGFloat height = (kItemWidth + (count -1) * kSpaceGap) * (count + 1);
            CGRect frame = self.frame;
            frame.size.height = height;
            
            for (int i = 0; i < count; i++) {
                ItemView *view = _items[i];
                frame.size.height = kItemWidth;
                frame.origin.x = 0;
                frame.origin.y = (i+1) * (kItemWidth+kSpaceGap);
                [view setCurrentPosition:frame.origin animation:YES operator:kOperatorTypeShow];
                [self insertSubview:view atIndex:0];
            }
        }
        
    } else {
        // 收回
        CGRect frame = self.frame;
        frame.size.height = kItemWidth;
        frame.origin.x = 0;
        frame.origin.y = 0;
        for (int i = 0; i < _items.count; i++) {
            ItemView *view = _items[i];
            [view setCurrentPosition:frame.origin animation:YES operator:kOperatorTypeHide];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - touch event
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    point.x = point.x + self.frame.size.width/2;
    point.y = point.y + self.frame.size.height/2;
    self.center = point;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _originalPosition = [touch locationInView:self];
    [self setHighlighted:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setHighlighted:NO];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    if (!CGPointEqualToPoint(_originalPosition, currentPosition)) {
        return;
    }
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    if (_selector != nil && event.type == UIEventTypeTouches) {
        [self sendAction:_selector to:_target forEvent:event];
    }
}

#pragma mark super method
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        showView.backgroundColor = [UIColor yellowColor];
    } else {
        showView.backgroundColor = [UIColor cyanColor];
    }
    
    [self _layoutSubViews];
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        showView.backgroundColor = [UIColor purpleColor];
    } else {
        showView.backgroundColor = [UIColor cyanColor];
    }
}

@end
