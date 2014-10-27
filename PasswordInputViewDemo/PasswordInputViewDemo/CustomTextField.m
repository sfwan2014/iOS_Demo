//
//  CustomTextField.m
//  PasswordInputViewDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomTextField.h"
#import "ItemView.h"

#define kMaxCount       9
#define kSpaceGap       5
#define kItemHeight     20

typedef enum : NSUInteger {
    kOperatorTypeDelete = 1,
    kOperatorTypeAdd,
    kOperatorTypeNone,
} kOperatorType;

@interface CustomTextField ()<UITextFieldDelegate>

@end

@implementation CustomTextField
{
    UIView *_inputView;
    NSMutableArray *_items;
    kOperatorType _type;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSArray *subViews = [self subviews];
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[NSClassFromString(@"UIFieldEditor") class]]) {
            if (_showPassword) {
                view.alpha = 1;
            } else {
                view.alpha = 0;
            }
        }
    }
    if (_showPassword) {
        [_inputView removeFromSuperview];
    } else {
        [self insertSubview:_inputView atIndex:subViews.count];
    }
}

-(void)_initView
{
    self.delegate = self;
    _inputView = [[UIView alloc] initWithFrame:self.bounds];
    _inputView.backgroundColor = [UIColor clearColor];
    _inputView.userInteractionEnabled = NO;
    _password = [NSMutableString string];
    _items = [[NSMutableArray alloc] init];
    _type = kOperatorTypeNone;
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _showPassword = NO;
//    self.inputAccessoryView.hidden = YES;
//    self.textInputView.hidden = YES;
//    self.secureTextEntry = YES;
//    self.inputView.hidden = YES;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];
}

-(void)setShowPassword:(BOOL)showPassword
{
    _showPassword = showPassword;
    [self setNeedsLayout];
}

-(void)reloadSubViews
{
    NSInteger count = _password.length;
    if (count > kMaxCount) {
        count = kMaxCount;
    }
    
    for (UIView *view in _items) {
        [view removeFromSuperview];
    }
    
    [_items removeAllObjects];
    
    if (count ==1 && _type == kOperatorTypeDelete) {
        return;
    }
    
    for (int i = 0; i < count; i++) {
        CGRect frame =  CGRectMake(5+i*(kItemHeight+kSpaceGap), (self.frame.size.height - kItemHeight)/2.0, kItemHeight, kItemHeight);
        ItemView *view = [[ItemView alloc] initWIthImage:[UIImage imageNamed:_imageName] frame:frame];
        [_inputView addSubview:view];
        [_items addObject:view];
    }
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    _password = textField.text;
}
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    _password mutableCopy
    
    if (_password.length >= 1 && [string isEqualToString:@""]) {
        if (_password.length == 1) {
            _type = kOperatorTypeDelete;
            _password = [NSMutableString string];
        } else {
            _password  = [[_password substringToIndex:_password.length-1] mutableCopy];
            _type = kOperatorTypeNone;
        }
    } else {
        if (_password.length >= kMaxCount) {
            return NO;
        }
        _type = kOperatorTypeAdd;
        [_password appendString:string];
    }
    
    [self reloadSubViews];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", _password);
    return YES;
}

@end
