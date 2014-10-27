//
//  PersonalCenterController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "PersonalCenterController.h"
#import "AboutQuestionBankViewController.h"
#import "QuestionFeedbackViewController.h"
#import "UserFeedbackViewController.h"

@interface PersonalCenterController ()
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (weak, nonatomic) IBOutlet UIButton *btnSystemMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnUserInfo;

@end

@implementation PersonalCenterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.title = @"个人中心";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _initViews];
}

#pragma mark - private Method
-(void)_initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"personalCenter_btn2_image.png"];
    image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [_btnLogout setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:@"personalCenter_btn1_image.png"];
    image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [_btnSystemMsg setBackgroundImage:image forState:UIControlStateNormal];
    [_btnUserInfo setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)_initNavgationItems
{
    [self initBackItem];
}

- (IBAction)logoutAction:(id)sender {
    // 登出
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)systemMessageAction:(id)sender {
    // 系统消息
}
- (IBAction)userInfoAction:(id)sender {
    // 账户信息
}


- (IBAction)aboutQuestionBank:(id)sender {
    AboutQuestionBankViewController *about = [[AboutQuestionBankViewController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}

- (IBAction)questionFeedback:(id)sender {
    QuestionFeedbackViewController *quest = [[QuestionFeedbackViewController alloc] init];
    [self.navigationController pushViewController:quest animated:YES];
}
- (IBAction)userFeedback:(id)sender {
    UserFeedbackViewController *user = [[UserFeedbackViewController alloc] init];
    [self.navigationController pushViewController:user animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
