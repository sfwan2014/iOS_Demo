//
//  MyCell.m
//  TableViewCellDemo
//
//  Created by shaofa on 14-6-9.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "MyCell.h"

@interface MyCell()
@property (weak, nonatomic) IBOutlet UIView *addBtnBackView;
@property (weak, nonatomic) IBOutlet UIView *delBtnBackView;
@property (weak, nonatomic) IBOutlet UIView *titleBackView;

@end

@implementation MyCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setText:(NSString *)text
{
    _text = text;
    _txtLabel.text = text;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_text.length == 0) {
        self.addBtnBackView.hidden = NO;
        self.delBtnBackView.hidden = YES;
    } else {
        self.addBtnBackView.hidden = YES;
        self.delBtnBackView.hidden = NO;
    }
    
    
    if (self.isFirst) {
        _titleBackView.hidden = NO;
    } else {
        _titleBackView.hidden = YES;
    }
}

- (IBAction)deleteBtnClickAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(MyCellDeleteItem:item:)]) {
        [self.delegate MyCellDeleteItem:self item:_text];
    }
}
- (IBAction)addBtnClickAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(MyCellAddItem:item:)]) {
        [self.delegate MyCellAddItem:self item:nil];
    }
}

@end
