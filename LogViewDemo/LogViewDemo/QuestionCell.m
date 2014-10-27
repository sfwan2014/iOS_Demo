//
//  QuestionCell.m
//  LogViewDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "QuestionCell.h"

@interface QuestionCell ()
@property (weak, nonatomic) IBOutlet UIView *questionBackView;
@property (weak, nonatomic) IBOutlet UIImageView *questionBubbleView;
@property (weak, nonatomic) IBOutlet UIImageView *questionPortraitView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIView *answerBackView;
@property (weak, nonatomic) IBOutlet UIImageView *answerPortraitView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *answerBubbleView;

@end

@implementation QuestionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.contentView addSubview:self.questionBackView];
    [self.contentView addSubview:self.answerBackView];
    
    UIImage *questImage = [UIImage imageNamed:@"question_bubble_image.png"];
    questImage = [questImage stretchableImageWithLeftCapWidth:50 topCapHeight:76];
    self.questionBubbleView.image = questImage;
    
    UIImage *answerImage = [UIImage imageNamed:@"answer_bubble_image.png"];
    answerImage = [answerImage stretchableImageWithLeftCapWidth:40 topCapHeight:56];
    self.answerBubbleView.image = answerImage;
}

-(void)setContent:(NSString *)content
{
    _content = content;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.questionBackView.hidden = YES;
    self.answerBackView.hidden = YES;
    
    CGRect frame = self.bounds;
    NSString *text = [Tools handleContent:_content];
    CGFloat width = [Tools widthFromContent:text labelWidth:kLabelDefaultWidth font:[UIFont systemFontOfSize:14]];
    CGFloat height = [Tools heightFromContent:text labelWidth:width font:[UIFont systemFontOfSize:14]];
    
    if ([_content hasPrefix:kAnswerPrefix]) {
        
        if (text.length == 0) {
            self.answerBackView.hidden = YES;
            return;
        }
        self.answerBackView.frame = frame;
        self.answerBackView.hidden = NO;
        
        self.answerLabel.text = text;
        
        self.answerBubbleView.height = height +kSpaceHeight;
        self.answerLabel.height = height;
        self.answerBubbleView.bottom = self.answerBackView.bottom - 5;
        self.answerLabel.bottom = self.answerBubbleView.bottom - kSpaceHeight/2.0;
        
        self.answerBubbleView.width = width + kSpaceWidth;
        self.answerLabel.width = width;
        self.answerBubbleView.right = self.answerPortraitView.left;
        self.answerLabel.right = self.answerBubbleView.right - kRightWidth;
        
        
    } else if ([_content hasPrefix:kQuestionPrefix]) {
        
        if (text.length == 0) {
            self.questionBackView.hidden = YES;
            return;
        }
        
//        [self.contentView addSubview:self.questionBackView];
        self.questionBackView.hidden = NO;
        self.questionBackView.frame = frame;
        self.questionLabel.text = text;
        
        self.questionBubbleView.height = height +kSpaceHeight;
        self.questionLabel.height = height;
        self.questionBubbleView.bottom = self.questionBackView.bottom -5;
        self.questionLabel.bottom = self.questionBubbleView.bottom - kSpaceHeight/2.0;
        
        self.questionBubbleView.width = width + kSpaceWidth;
        self.questionLabel.width = width;
        self.questionBubbleView.left = self.questionPortraitView.right;
        self.questionLabel.left = self.questionBubbleView.left + kLeftWidth;
    }
}

@end
