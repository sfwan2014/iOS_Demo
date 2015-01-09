//
//  InputAmountView.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "InputAmountView.h"

@interface InputAmountView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation InputAmountView
{
    NSObject *_observer;
}
-(void)awakeFromNib{
    _amountTextField.delegate = self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length > 0){
        [textField selectAll:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.amount = [textField.text integerValue];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string integerValue] == 0 && textField.text.length == 0) {
        return NO;
    }
    
    if (textField.text.length>=4 && string.length > 0) {
        return NO;
    }
    
    if (string.length>0) {
        NSMutableString *appString = [NSMutableString string];
        [appString appendFormat:@"%@%@", textField.text, string];
        self.amount = [appString integerValue];
    } else {
        self.amount = [[textField.text substringToIndex:textField.text.length -1] integerValue];
    }
    
    return YES;
}

-(void)becomeFirstResponse{
    [_amountTextField becomeFirstResponder];
}

-(void)setAmount:(NSInteger)amount{
    _amount = amount;
//    if (amount > 0 && amount <= 9999) {
//        _alertView.hidden = YES;
//    } else {
//        _alertView.hidden = NO;
//    }
}

-(void)addObserver:(NSObject *)observer{
    [self addObserver:observer forKeyPath:@"self.amount" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)refresh{
    _amountTextField.text = @"";
    self.amount = 0;
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    
    [self removeObserver:_observer forKeyPath:@"self.amount"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
