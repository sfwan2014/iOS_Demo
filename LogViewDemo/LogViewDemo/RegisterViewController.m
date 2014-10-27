//
//  RegisterViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-25.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RegisterViewController.h"

#define kCountDownNum           10

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// 输入手机号码
@property (strong, nonatomic) IBOutlet UIView *viewInputPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;


// 输入短信验证码
@property (strong, nonatomic) IBOutlet UIView *viewInputCheckCode;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCheckBack;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCheckCode;
@property (weak, nonatomic) IBOutlet UILabel *labelCheckCountDown;
@property (weak, nonatomic) IBOutlet UILabel *labelCheckPhoneNum;
@property (weak, nonatomic) IBOutlet UIButton *btnCountDown;

// 输入密码
@property (strong, nonatomic) IBOutlet UIView *viewInputPswd;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInputPswd;
@property (weak, nonatomic) IBOutlet UITextField *textFieldReinputPswd;

// 注册成功
@property (strong, nonatomic) IBOutlet UIView *viewRegisterSucceed;
@end

@implementation RegisterViewController

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

    self.title = @"手机验证";
    
    [self _initViews];
    // 添加背景图片
    [self addBackgroundImageView];
}

#pragma mark - private method
-(void)_initNavgationItems
{
    [self initBackItem];
}


-(void)_initViews
{
    _labelCheckCountDown.text = [NSString stringWithFormat:@"重发"];
    
    
    float width = 4 * kSCreenWidth;
    self.scrollView.contentSize = CGSizeMake(width, self.scrollView.frame.size.height);
    CGRect frame = self.scrollView.frame;
    self.viewInputPhoneNumber.frame = frame;
    
    frame.origin.x = kSCreenWidth;
    self.viewInputCheckCode.frame = frame;
    
    frame.origin.x = kSCreenWidth * 2;
    self.viewInputPswd.frame = frame;
    
    frame.origin.x = kSCreenWidth * 3;
    self.viewRegisterSucceed.frame = frame;
}

#pragma mark - button action
- (IBAction)tapAction:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


// 输入手机号码下一步
- (IBAction)btnActionPhoneNumber:(id)sender {
    [self scrollToPage:1];
}

// 校验验证码下一步
- (IBAction)btnActionCheckCode:(id)sender {
    [self scrollToPage:2];
    self.title = @"输入密码";
}

// 重新发送验证码
- (IBAction)btnActionReGetCheckCode:(UIButton *)sender {
    sender.selected = !sender.selected;
    _imageViewCheckBack.highlighted = YES;
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(addTimer) object:nil];
    [thread start];
}

// 输入密码下一步
- (IBAction)btnActionInputPswd:(id)sender {
    [self scrollToPage:3];
    [self tapAction:nil];// 隐藏键盘
    self.title = @"注册成功";
}

// 登录
- (IBAction)btnActionLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollToPage:(int)page
{
    CGPoint point = self.scrollView.contentOffset;
    point.x = kSCreenWidth * page;
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = point;
    }];
}


#pragma mark - UITextField delegate
-(BOOL)checkPhoneNumber:(NSString *)phoneNum
{
    if ([phoneNum hasPrefix:@"1"] && phoneNum.length == 11) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    if (textField == _textFieldPhoneNumber) {
        // 号码字数限制
        if (text.length >= 11 && string.length != 0) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - timer Action
-(void)addTimer
{
    _btnCountDown.enabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
}

-(void)timerAction:(NSTimer *)timer
{
    static int time = kCountDownNum;
    int lastTime =time;
    dispatch_sync(dispatch_get_main_queue(), ^{
        _labelCheckCountDown.text = [NSString stringWithFormat:@"%d秒后重发", lastTime];
    });
    
    if (time == 0) {
        time = kCountDownNum;
        [timer invalidate];
        _btnCountDown.enabled = YES;
        _imageViewCheckBack.highlighted = NO;
        _labelCheckCountDown.text = @"重发";
    }
    
    time--;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
