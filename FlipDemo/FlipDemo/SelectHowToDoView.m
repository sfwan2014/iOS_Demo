//
//  SelectHowToDoView.m
//  FinancialManageClient
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "SelectHowToDoView.h"

@interface SelectHowToDoView ()
@property (weak, nonatomic) IBOutlet UIButton *saleAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *salePartBtn;
@property (weak, nonatomic) IBOutlet UIButton *remainUnchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *contineAddBtn;


@property (weak, nonatomic) IBOutlet UIImageView *selectedMarkView;
@property (weak, nonatomic) IBOutlet UIImageView *indexOneView;
@property (weak, nonatomic) IBOutlet UIImageView *indexTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *indexThreeView;
@property (weak, nonatomic) IBOutlet UIImageView *indexFourView;
@property (weak, nonatomic) IBOutlet UILabel *selectedResultLabel;
@end

@implementation SelectHowToDoView
{
    NSObject *_observer;
}

-(void)awakeFromNib{
    self.howToDoIndex = -1;
    _selectedMarkView.hidden = YES;
}

-(void)becomeFirstResponse{
    self.howToDoIndex = _howToDoIndex;
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)addObserver:(NSObject *)observer{
    [self addObserver:observer forKeyPath:@"self.howToDoIndex" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    
    [self removeObserver:_observer forKeyPath:@"self.howToDoIndex"];
}

- (IBAction)saleAllAction:(UIButton *)sender {
    self.howToDoIndex = 1;
    [self unSelected];
    sender.selected = YES;
    _indexOneView.highlighted = YES;
    [self moveMark:sender];
}
- (IBAction)salePartAction:(UIButton *)sender {
    self.howToDoIndex = 2;
    [self unSelected];
    sender.selected = YES;
    _indexTwoView.highlighted = YES;
    [self moveMark:sender];
}

- (IBAction)holdOnAction:(UIButton *)sender {
    self.howToDoIndex = 3;
    [self unSelected];
    sender.selected = YES;
    _indexThreeView.highlighted = YES;
    [self moveMark:sender];
}

- (IBAction)continueAddAction:(UIButton *)sender {
    self.howToDoIndex = 4;
    [self unSelected];
    sender.selected = YES;
    _indexFourView.highlighted = YES;
    [self moveMark:sender];
}

-(void)moveMark:(UIButton *)sender{
//    _selectedMarkView.hidden = NO;
    _selectedMarkView.frame = CGRectMake(_selectedMarkView.frame.origin.x, sender.frame.origin.y, _selectedMarkView.frame.size.width, _selectedMarkView.frame.size.height);
}

-(void)unSelected{
    _selectedMarkView.hidden = YES;
    _saleAllBtn.selected = NO;
    _salePartBtn.selected = NO;
    _remainUnchangeBtn.selected = NO;
    _contineAddBtn.selected = NO;
    
    _indexOneView.highlighted = NO;
    _indexTwoView.highlighted = NO;
    _indexThreeView.highlighted = NO;
    _indexFourView.highlighted = NO;
}

-(void)refresh{
    [self unSelected];
    self.howToDoIndex = 0;
}

@end
