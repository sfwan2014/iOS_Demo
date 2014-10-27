//
//  RootViewController.m
//  PasswordInputViewDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "CustomTextField.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet CustomTextField *textField;

@end

@implementation RootViewController

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

    [_textField becomeFirstResponder];
    _textField.imageName = @"circle1.png";
}

- (IBAction)showPasswordAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _textField.showPassword = YES;
    } else {
        _textField.showPassword = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
