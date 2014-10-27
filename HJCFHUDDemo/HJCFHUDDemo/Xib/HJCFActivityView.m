//
//  HJCFActivityView.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFActivityView.h"

@interface HJCFActivityView ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation HJCFActivityView

+(id)loadFromNib
{
    UIView *view = [super loadFromNib];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    
    return view;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setMsg:(NSString *)msg
{
    _msg = msg;
    CGSize size = [msg sizeWithFont:_messageLabel.font constrainedToSize:CGSizeMake(1000, 21)];
    CGRect frame = CGRectMake(0, 0, size.width, 21);
    _messageLabel.text = msg;
}

@end
