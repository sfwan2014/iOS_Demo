//
//  SelectAttentionView.m
//  FinancialManageClient
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "SelectAttentionView.h"
@interface SelectAttentionView()
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIButton *shouyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunshiBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianguBtn;
@property (weak, nonatomic) IBOutlet UIImageView *selectedMarkView;
@property (weak, nonatomic) IBOutlet UIImageView *indexOneView;
@property (weak, nonatomic) IBOutlet UIImageView *indexTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *indexThreeView;

@end
@implementation SelectAttentionView
{
    NSObject *_observer;
}
-(void)awakeFromNib{
    self.attentionIndex = -1;
    _selectedMarkView.hidden = YES;
}
-(void)becomeFirstResponse{
    self.attentionIndex = _attentionIndex;
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)addObserver:(NSObject *)observer{
    [self addObserver:observer forKeyPath:@"self.attentionIndex" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    
    [self removeObserver:_observer forKeyPath:@"self.attentionIndex"];
}

- (IBAction)showyiAction:(UIButton *)sender {
    self.attentionIndex = 1;
    [self unSelected];
    
    sender.selected = YES;
    _indexOneView.highlighted = YES;
    [self moveMark:sender];
}

- (IBAction)sunshiAction:(UIButton *)sender {
    self.attentionIndex = 2;
    [self unSelected];
    
    sender.selected = YES;
    _indexTwoView.highlighted = YES;
    [self moveMark:sender];
}

- (IBAction)jianguAction:(UIButton *)sender {
    self.attentionIndex = 3;
    [self unSelected];
    
    sender.selected = YES;
    _indexThreeView.highlighted = YES;
    [self moveMark:sender];
}

-(void)unSelected{
    _selectedMarkView.hidden = YES;
    _shouyiBtn.selected = NO;
    _jianguBtn.selected = NO;
    _sunshiBtn.selected = NO;
    
    _indexOneView.highlighted = NO;
    _indexTwoView.highlighted = NO;
    _indexThreeView.highlighted = NO;
}

-(void)refresh{
    [self unSelected];
    self.attentionIndex = 0;
}

-(void)moveMark:(UIButton *)sender{
//    _selectedMarkView.hidden = NO;
    _selectedMarkView.frame = CGRectMake(_selectedMarkView.frame.origin.x, sender.frame.origin.y, _selectedMarkView.frame.size.width, _selectedMarkView.frame.size.height);
}

@end
