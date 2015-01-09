//
//  InputInvestView.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "InputInvestView.h"

@interface InputInvestView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *investTextField;
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation InputInvestView
{
    NSObject *_observer;
}
-(void)awakeFromNib{
    _investTextField.delegate = self;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length > 0){
        [textField selectAll:self];
    }

//    self.invest = [textField.text integerValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.invest = [textField.text integerValue];
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
        self.invest = [appString integerValue];
    } else {
        self.invest = [[textField.text substringToIndex:textField.text.length -1] integerValue];
    }
    
    return YES;
}

-(void)setInvest:(NSInteger)invest{
    _invest = invest;
//    if (invest > 0 && invest <= 9999) {
//        _alertView.hidden = YES;
//    } else {
//        _alertView.hidden = NO;
//    }
}

#pragma mark - override
-(void)becomeFirstResponse{
    [_investTextField becomeFirstResponder];
}

-(void)addObserver:(NSObject *)observer{
    [self addObserver:observer forKeyPath:@"self.invest" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)refresh{
    _investTextField.text = @"";
    self.invest = 0;
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    
    [self removeObserver:_observer forKeyPath:@"self.invest"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
