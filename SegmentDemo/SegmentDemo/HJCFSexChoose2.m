//
//  HJCFSexChoose2.m
//  FinancialManage
//
//  Created by Lee on 14-8-11.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import "HJCFSexChoose2.h"
#import "UIViewExt.h"

#define kLeftSpace      5
#define kSpaceHeight    15

@implementation HJCFSexChoose2
{
    CGPoint _startPosition;
    UIImageView *_boyView;
    UILabel *_boyLabel;
    UIView *_line;
    UIImageView *_girlView;
    UILabel *_girlLabel;
    
    SEL _selector;
    id _target;
}
- (id)initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _target = target;
        _selector = selector;
        [self _initViews];
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _selector = action;
}

- (void)_initViews
{
    _selectedIndex=-1;
    _boyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiben_boy_wei"]];
    [_boyView setHighlightedImage:[UIImage imageNamed:@"jiben_boy"]];
    _boyView.frame = CGRectZero;
    [self addSubview:_boyView];
    
    _boyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _boyLabel.text = @"男";
    _boyLabel.textColor = [UIColor grayColor];
    _boyLabel.highlightedTextColor = [UIColor blackColor];
    [self addSubview:_boyLabel];
    
    _line = [[UIView alloc]initWithFrame:CGRectZero];
    _line.backgroundColor = [UIColor grayColor];
    [self addSubview:_line];
    
    _girlView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiben_gil_wei"]];
    [_girlView setHighlightedImage:[UIImage imageNamed:@"jiben_gil"]];
    _girlView.frame = CGRectZero;
    [self addSubview:_girlView];
    
    _girlLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _girlLabel.text = @"女";
    _girlLabel.textAlignment = NSTextAlignmentRight;
    _girlLabel.textColor = [UIColor grayColor];
    _girlLabel.highlightedTextColor = [UIColor blackColor];
    [self addSubview:_girlLabel];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    _boyLabel.textColor = [UIColor grayColor];
    _girlLabel.textColor = [UIColor grayColor];
    if (_selectedIndex==0) {
        _boyView.highlighted = YES;
        _girlView.highlighted = NO;
        _boyLabel.textColor = [UIColor blueColor];
    }else if(_selectedIndex==1){
        _boyView.highlighted = NO;
        _girlView.highlighted = YES;
        _girlLabel.textColor = [UIColor purpleColor];
    }else{
        _boyView.highlighted = NO;
        _girlView.highlighted = NO;
    }
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _initViews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = self.height - kLeftSpace*2;
    _boyView.frame = CGRectMake(kLeftSpace, kLeftSpace, height, height);
    _boyLabel.frame = CGRectMake(_boyView.right, 0, self.width/2.0-_boyView.width-kLeftSpace, self.height);
    _girlView.frame = CGRectMake(0, kLeftSpace, height, height);
    _girlView.right = self.width - kLeftSpace;
    _girlLabel.frame = CGRectMake(0, 0, self.width/2.0-_girlView.width-kLeftSpace, self.height);
    _girlLabel.right = _girlView.left - kLeftSpace;
    _line.frame = CGRectMake(self.width/2.0 - kLeftSpace, kSpaceHeight, 1, self.height - kSpaceHeight * 2);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.frame.size.width/2;
    UITouch *touch = [touches anyObject];
    _startPosition = [touch locationInView:self];
    NSInteger index = _startPosition.x/width;
    self.selectedIndex = index;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.frame.size.width/2;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger index = point.x/width;
    self.selectedIndex = index;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self sendAction:_selector to:_target forEvent:event];
}


@end
