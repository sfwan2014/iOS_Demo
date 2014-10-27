//
//  OrderTableViewCell.m
//  CaculateForCellDemo
//
//  Created by sfwan on 14-10-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "OrderTableViewCell.h"
@interface OrderTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, assign) NSInteger count;
@end
@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOriginalCount:(NSInteger)originalCount
{
    _originalCount = originalCount;
    _textField.text = [NSString stringWithFormat:@"%d", originalCount];
    
    [self setCount];
    [self showTotal];
    [self finishCaculate:NO];
    [self setNeedsLayout];
}

- (IBAction)subAction:(id)sender {
    [self setCount];
    _count--;
    [self showCount];
}
- (IBAction)addAction:(id)sender {
    [self setCount];
    _count++;
    [self showCount];
}


#pragma mark - delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self showTotal];
    [self finishCaculate:YES];
    
}

-(void)showCount
{
    _textField.text = [NSString stringWithFormat:@"%ld", (long)_count];
    [self showTotal];
    [self finishCaculate:YES];
}

-(void)finishCaculate:(BOOL)refresh
{
    if (_block) {
        _block(@[_textField.text, _label.text], refresh);
    }
}

-(void)showTotal
{
    [self setCount];
    _label.text = [NSString stringWithFormat:@"%.2f", self.count * 2.4];
}

-(void)setCount
{
    _count = [_textField.text integerValue];
}

@end
