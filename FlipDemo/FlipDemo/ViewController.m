//
//  ViewController.m
//  FlipDemo
//
//  Created by sfwan on 14-12-18.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "InputAgeView.h"
#import "InputAmountView.h"
#import "InputInvestView.h"
#import "SelectAttentionView.h"
#import "SelectHowToDoView.h"
#import "UIView+MDXibView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *controlBackView;

@end

@implementation ViewController
{
    NSInteger _current;
    NSInteger _last;
    NSInteger _next;
    NSMutableArray *changeViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _current = 0;
    changeViews = [NSMutableArray array];
    UIView *ageView = [InputAgeView loadViewWithNibName:NSStringFromClass([InputAgeView class])];
    UIView *amountView = [InputAmountView loadViewWithNibName:NSStringFromClass([InputAmountView class])];
    UIView *investView = [InputInvestView loadViewWithNibName:NSStringFromClass([InputInvestView class])];
    UIView *attentionView = [SelectAttentionView loadViewWithNibName:NSStringFromClass([SelectAttentionView class])];
    UIView *howToDoView = [SelectHowToDoView loadViewWithNibName:NSStringFromClass([SelectHowToDoView class])];
    
    [self.view addSubview:ageView];
    [changeViews addObject:ageView];
    [self.view addSubview:investView];
    [changeViews addObject:investView];
    [self.view addSubview:amountView];
    [changeViews addObject:amountView];
    [self.view addSubview:attentionView];
    [changeViews addObject:attentionView];
    [self.view addSubview:howToDoView];
    [changeViews addObject:howToDoView];
    [self setSubViewHide];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(tm) userInfo:nil repeats:YES];
}

-(void)setSubViewHide{
    for (UIView *view in changeViews) {
        view.frame = CGRectMake(self.view.frame.size.width, 0, view.frame.size.width, view.frame.size.height);
        view.backgroundColor = [UIColor cyanColor];
    }
}

-(void)tm{
    static NSInteger count = 0;
    
    _last = _current;
    _current = count;
    count++;
    
    if (count > changeViews.count-1) {
        count = 0;
    }
    _next = count;
    [self showSubviews];
}

-(void)showSubviews{
//    [self setSubViewHide];
    CGFloat width = self.view.frame.size.width;
//    UIView *lastView = changeViews[_last];
    UIView *currentView = changeViews[_current];
    UIView *nextView = changeViews[_next];
    nextView.frame = CGRectMake(width, 50, width, nextView.frame.size.height);
    currentView.frame = CGRectMake(0, 50, width, currentView.frame.size.height);
    [UIView animateWithDuration:0.35 animations:^{
        nextView.frame = CGRectMake(0, 50, width, nextView.frame.size.height);
        currentView.frame = CGRectMake(-width, 50, width, currentView.frame.size.height);
        _controlBackView.frame = CGRectMake(_controlBackView.frame.origin.x, nextView.frame.origin.y+nextView.frame.size.height, _controlBackView.frame.size.width, _controlBackView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
