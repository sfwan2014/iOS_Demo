//
//  MDQuestView.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDQuestView.h"
#import "InputAgeView.h"
#import "InputAmountView.h"
#import "InputInvestView.h"

#import "UIView+MDXibView.h"

@interface MDQuestView()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MDQuestView{
    NSMutableArray *_subViews;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initViews];
}

-(void)_initViews{
    CGFloat width = self.frame.size.width;
    _subViews = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIView *view = [self createViewWithStep:i];
        [_scrollView addSubview:view];
        [_subViews addObject:view];
    }
    _scrollView.contentSize = CGSizeMake(width*5, 0);
}

-(UIView *)createViewWithStep:(NSInteger)step{
    switch (step) {
        case 0:
        {
            UIView *view = [InputAgeView loadViewWithNibName:@"InputAgeView"];
            return view;
        }
            break;
        case 1:
        {
            UIView *view = [InputAmountView loadViewWithNibName:@"InputAmountView"];
            return view;
        }
            break;
        case 2:
        {
            UIView *view = [InputAmountView loadViewWithNibName:@"InputInvestView"];
            return view;
        }
            break;
        case 3:
        {
            UIView *view = [InputAmountView loadViewWithNibName:@"InputInvestView"];
            return view;
        }
            break;
        case 4:
        {
            UIView *view = [InputAmountView loadViewWithNibName:@"InputInvestView"];
            return view;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

-(void)setStep:(NSInteger)step{
    _step = step;
    CGFloat width = self.frame.size.width;
    CGPoint contentOffset = CGPointMake(width*step, 0);
    [UIView animateWithDuration:0.35 animations:^{
        _scrollView.contentOffset = contentOffset;
    }];
    
    [_progressView setProgress:step/5.0 animated:YES];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    for (int i = 0; i < _subViews.count; i++) {
        UIView *view = _subViews[i];
        view.frame = CGRectMake(width * i, 0, view.frame.size.width, view.frame.size.height);
    }
}

@end
