//
//  RecordsTableCell.m
//  TableViewOpenAndCloseDemo
//
//  Created by sfwan on 14-12-12.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "RecordsTableCell.h"

@implementation RecordsTableCell{
    UILabel *dateLabel;
    UILabel *amountLabel;
    UILabel *emptyMessage;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = [UIColor darkGrayColor];

    amountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    amountLabel.textAlignment = NSTextAlignmentLeft;
    amountLabel.font = [UIFont systemFontOfSize:13];
    amountLabel.textColor = [UIColor redColor];
    
    emptyMessage = [[UILabel alloc] initWithFrame:CGRectZero];
    emptyMessage.textAlignment = NSTextAlignmentLeft;
    emptyMessage.font = [UIFont systemFontOfSize:13];
    emptyMessage.textColor = [UIColor darkGrayColor];
    emptyMessage.hidden = YES;
    
    [self.contentView addSubview:dateLabel];
    [self.contentView addSubview:amountLabel];
    [self.contentView addSubview:emptyMessage];
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_model.idStr == nil) {
        emptyMessage.hidden = NO;
        
        emptyMessage.frame = CGRectMake(10, 5, 150, 30);
        emptyMessage.text = @"无记录";
        dateLabel.hidden = YES;
        amountLabel.hidden = YES;
        return;
    } else {
        emptyMessage.hidden = YES;
        
        dateLabel.hidden = NO;
        amountLabel.hidden = NO;
    }
    
    dateLabel.frame = CGRectMake(10, 5, 150, 30);
    amountLabel.frame = CGRectMake(176, 5, 100, 30);
    
    dateLabel.text = _model.confirmtime;
    amountLabel.text = _model.amount;
}

@end
