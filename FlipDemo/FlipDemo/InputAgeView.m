//
//  InputAgeView.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "InputAgeView.h"

@interface InputAgeView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation InputAgeView
{
    NSObject *_observer;
}

-(void)awakeFromNib{
    _ageTextField.delegate = self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length > 0){
        [textField selectAll:self];
    }
//    _alertView.hidden = YES;
//    self.age = [textField.text integerValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.age = [textField.text integerValue];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string integerValue] == 0 && textField.text.length == 0) {
        return NO;
    }
    
    if (textField.text.length>=2 && string.length > 0) {
        return NO;
    }
    
    if (string.length>0) {
        NSMutableString *appString = [NSMutableString string];
        [appString appendFormat:@"%@%@", textField.text, string];
        self.age = [appString integerValue];
    } else {
        self.age = [[textField.text substringToIndex:textField.text.length -1] integerValue];
    }
    
    return YES;
}

-(void)becomeFirstResponse{
    [_ageTextField becomeFirstResponder];
}

-(void)addObserver:(NSObject *)observer{
    _observer = observer;
    [self addObserver:observer forKeyPath:@"self.age" options:NSKeyValueObservingOptionNew context:nil];
}



-(void)setAge:(NSInteger)age{
    _age = age;
    
//    if (age >= 18 && age <= 100) {
//        _alertView.hidden = YES;
//    } else {
//        _alertView.hidden = NO;
//    }
}

-(void)refresh{
    _ageTextField.text = @"";
    self.age = 0;
}


-(void)removeFromSuperview{
    [super removeFromSuperview];
    
    [self removeObserver:_observer forKeyPath:@"self.age"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
