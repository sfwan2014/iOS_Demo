//
//  UserFeedbackViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-30.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//


#import "UserFeedbackViewController.h"

typedef enum : NSUInteger {
    kInputViewStyleTextField = 0,
    kInputViewStyleTextView,
} kInputViewStyle;

@interface UserFeedbackViewController ()<UITextFieldDelegate, UITextViewDelegate>

@end

@implementation UserFeedbackViewController
{
    kInputViewStyle _inputViewStyle;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"用户提问";
    
    self.view.backgroundColor = RGB(226, 226, 226);
    
    [self addKeyboardNotification];
}


-(void)_initNavgationItems
{
    [self initBackItem];
}


#pragma mark - delegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    _inputViewStyle = kInputViewStyleTextField;
    return  YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _inputViewStyle = kInputViewStyleTextView;
    CGRect frame = CGRectMake(0, 0, 320, 216);
    [self layoutSubViewsWithFrame:frame];
    return YES;
}


#pragma mark - notificationAction
-(void)keyboardAppearAction:(NSNotification *)notification
{
    if (_inputViewStyle == kInputViewStyleTextView) {
        NSDictionary *dic = notification.userInfo;
        
        // 键盘显示 重新布局  (0, 352)(320, 216)
        CGRect frame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self layoutSubViewsWithFrame:frame];
    }
}

-(void)layoutSubViewsWithFrame:(CGRect)frame
{
    [UIView animateWithDuration:0.35 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -frame.size.height/2.0);
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)confirmBtnAction:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
