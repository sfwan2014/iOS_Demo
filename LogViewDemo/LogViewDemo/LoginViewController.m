//
//  LoginViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-25.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "LoginViewController.h"
#import "SSKeychain.h"
#import "RegisterViewController.h"
#import "PersonalCenterController.h"
#import "QuestionAndAnswerViewController.h"

#define kMyAppName      @"MyApp"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswdTextField;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumCheckImgView;
@property (weak, nonatomic) IBOutlet UIImageView *pswdCheckImgView;
@property (weak, nonatomic) IBOutlet UIImageView *protraitImageView;
@property (weak, nonatomic) IBOutlet UIButton *savePswdBtn;

@end

@implementation LoginViewController
{
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"用户登陆";
    
    [self textFieldResigerObser:_phoneNumTextField];
    [self textFieldResigerObser:_pswdTextField];
    
    [self _readUserInfo];
    
    [self _initNavgationItems];
    // 添加背景图片
    [self addBackgroundImageView];
    
    [self addKeyboardNotification];
}

#pragma mark - private method
-(void)_initNavgationItems
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 36, 21);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"register_btn_image.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerAcountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

// 为textfield 注册观察者
-(void)textFieldResigerObser:(UITextField *)textfield
{
    [textfield addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:(__bridge void *)(textfield)];
}

-(void)_readUserInfo
{
    NSDictionary *account = [[SSKeychain accountsForService:kMyAppName] lastObject];
    NSString *password = [SSKeychain passwordForService:kMyAppName account:account[@"acct"]];
    _phoneNumTextField.text = account[@"acct"];
    _pswdTextField.text = password;
    if (password.length > 0) {
        _savePswdBtn.selected = YES;
    } else {
        _savePswdBtn.selected = NO;
    }
}

-(void)_hideKeyboard
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - observeValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        NSString *new = change[@"new"];
        UITextField *textField = (__bridge UITextField *)context;
        if (textField == _phoneNumTextField) {
            [self checkPhoneNumber:new];
        } else if (textField == _pswdTextField) {
            [self checkPassword:new];
        }
    }
}

#pragma mark - button action
-(void)registerAcountAction:(UIButton *)sender
{
    // 注册
    NSLog(@"%@",@"注册");
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)savePasswordAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)findPasswordAction:(UIButton *)sender {
    // 找回密码
    QuestionAndAnswerViewController *question = [[QuestionAndAnswerViewController alloc] init];
    [self.navigationController pushViewController: question animated:YES];
}
- (IBAction)loginAction:(UIButton *)sender {
    // 登陆
    PersonalCenterController *personalCenter = [[PersonalCenterController alloc] init];
    [self.navigationController pushViewController:personalCenter animated:YES];
    
    // 保存密码
    if (self.savePswdBtn.selected) {
        [SSKeychain setPassword:_pswdTextField.text forService:kMyAppName account:_phoneNumTextField.text];
    } else {
        [SSKeychain deletePasswordForService:kMyAppName account:_phoneNumTextField.text];
    }
}
- (IBAction)tapAction:(id)sender {
    [self _hideKeyboard];
}


#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    if (textField == _phoneNumTextField) {
        // 检测号码是否匹配
        if (text.length == 11) {
            
            if (string.length != 0) {
                [self checkPhoneNumber:text];
            } else {
                [self checkPhoneNumber:[text substringToIndex:text.length -1]];
            }
            
        } else {
            [self checkPhoneNumber:[NSString stringWithFormat:@"%@%@", text, string]];
        }
        
        // 号码字数限制
        if (text.length >= 11 && string.length != 0) {
            return NO;
        }
    } else if (textField == _pswdTextField) {
        // 检测密码是否匹配
        if (text.length == 6) {
            
            if (string.length != 0) {
                [self checkPassword:text];
            } else {
                [self checkPassword:[text substringToIndex:text.length -1]];
            }
            
        } else {
            [self checkPassword:[NSString stringWithFormat:@"%@%@", text, string]];
        }
        
        // 密码字数限制
        if (text.length >= 16 && string.length != 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *text = textField.text;
    if (textField == _phoneNumTextField) {
        
        [self checkPhoneNumber:text];
        
    } else if (textField == _pswdTextField) {
        [self checkPassword:text];
    }
}

#pragma check number
-(void)checkPhoneNumber:(NSString *)phoneNum
{
    if ([phoneNum hasPrefix:@"1"] && phoneNum.length == 11) {
        _phoneNumCheckImgView.highlighted = YES;
    } else {
        _phoneNumCheckImgView.highlighted = NO;
    }
}

-(void)checkPassword:(NSString *)pswd
{
    if (pswd.length >= 6) {
        _pswdCheckImgView.highlighted = YES;
    } else {
        _pswdCheckImgView.highlighted = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [_pswdTextField removeObserver:self forKeyPath:@"text"];
//    [_phoneNumTextField removeObserver:self forKeyPath:@"text"];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
