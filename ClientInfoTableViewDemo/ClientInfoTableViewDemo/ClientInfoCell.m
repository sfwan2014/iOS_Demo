//
//  ClientInfoCell.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientInfoCell.h"
#import "ClientInfoTool.h"

@interface ClientInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoIconImageView;
@property (weak, nonatomic) IBOutlet UIView *clockBackView;
@property (weak, nonatomic) IBOutlet UILabel *clockTimeLabel;

@end

@implementation ClientInfoCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    BOOL clock = [_data[@"clock"] boolValue];
    if (clock) {
        _clockBackView.hidden = NO;
    } else {
        _clockBackView.hidden = YES;
    }
    
    NSDictionary *dic = _data[@"thing"];
    NSString *text = dic[@"content"];
    _contentLabel.text = text;
    
    CGSize size = [ClientInfoTool sizeWithContentStr:text fontSize:kDefaultContentFontSize];
    _contentLabel.height = size.height;
    _timeLabel.top = _contentLabel.bottom;
    _clockBackView.top = _timeLabel.bottom;
    
    
    NSString *type = dic[@"type"];
    if ([type isEqualToString:@"video"]) {
        _videoIconImageView.hidden = NO;
    } else {
        _videoIconImageView.hidden = YES;
    }
}

@end
