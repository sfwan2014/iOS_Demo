//
//  InvestmentAppraisalViewController.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "InvestmentAppraisalViewController.h"
#import "UIColor+String.h"
#import "MDQuestView.h"
#import "UIView+MDXibView.h"

@interface InvestmentAppraisalViewController ()
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UIView *nextBackView;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation InvestmentAppraisalViewController{
    NSInteger _step;
    MDQuestView *_questView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _step = 0;
    
    _questView = (MDQuestView *)[MDQuestView loadViewWithNibName:@"MDQuestView"];
    _questView.step = 0;
    [self.topBackView addSubview:_questView];
    [self showStepView:0];
}

//设置Autolayout中的边距辅助方法
- (void)setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}
- (IBAction)nextAction:(id)sender {
    _step++;
    if (_step >= 5) {
        return;
    }
    [self showStepView:_step];
}

- (IBAction)previousAction:(id)sender {
    _step--;
    if (_step < 0) {
        return;
    }
    [self showStepView:_step];
}

-(void)showStepView:(NSInteger)step{
    CGRect frame = [UIScreen mainScreen].bounds;
//    CGPoint origin = frame.origin;
    if (step < 3) {
        frame.size.height = 113;
    } else if (step == 3){
        frame.size.height = 206;
    } else {
        frame.size.height = 315;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.topBackView.frame = frame;
        _questView.frame = self.topBackView.bounds;
        _questView.step = step;
        
        CGRect rect = _nextBackView.frame;
        rect.size.width = frame.size.width;
        rect.origin.x = 0;
        rect.origin.y = _topBackView.frame.size.height + _topBackView.frame.origin.y;
        
        _nextBackView.frame = rect;
    }];
    
    frame = [UIScreen mainScreen].bounds;
    _bottomBackView.frame = CGRectMake(0, frame.size.height-_bottomBackView.frame.size.height, frame.size.width, _bottomBackView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
