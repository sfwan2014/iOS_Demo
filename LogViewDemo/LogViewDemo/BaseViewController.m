//
//  BaseViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-25.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "BaseViewController.h"
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    
    [self _initNavgationItems];
    
    self.view.backgroundColor = [UIColor clearColor];
    
}

//ios 7 适配问题
- (void) viewDidLayoutSubviews {
    if (ABOVE_IOS7) {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
}

#pragma mark - private Method
-(void)addBackgroundImageView// 添加背景图片
{
    [self addBackgroundImageViewWithImageName:@"back_image.png"];
}

-(void)addBackgroundImageViewWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *backView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.image = image;
    backView.contentMode = UIViewContentModeScaleToFill;
    
    [self.view insertSubview:backView atIndex:0];
}

-(void)_initNavgationItems
{
    
}

-(void)addKeyboardNotification
{
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppearAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappearAction:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - notificationAction
-(void)keyboardAppearAction:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    // 键盘显示 重新布局
    CGRect frame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.35 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -frame.size.height/2.0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)keyboardDisappearAction:(NSNotification *)notification
{
    
    // 键盘隐藏 重新布局
    [UIView animateWithDuration:0.35 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)initBackItem
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 38, 38);
    [leftBtn setImage:[UIImage imageNamed:@"nav_left_item_backImg.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tap Action
- (IBAction)tapAction:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
