//
//  SubViewController.m
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SubViewController.h"


@interface SubViewController ()

@end

@implementation SubViewController
{
    UIView *bottomView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 88)];
    topView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:topView];
    
}

//-(void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    CGRect frame = self.view.frame;
//    if (iOS7_OR_LATER && self.navigationController.navigationBarHidden) {
//        
//        self.navigationController.navigationBar.superview.backgroundColor = [UIColor blackColor];
//        frame.origin.y = 20;
//        frame.size.height = kScreenHeight - 20;
//        self.view.superview.frame = frame;
//        self.view.height = self.view.superview.height;
//        bottomView.bottom = self.view.bottom;
//    } else {
//        if (!self.navigationController.navigationBarHidden) {
//            frame.origin.y = 0;
//            frame.size.height = kScreenHeight - 64;
//            self.view.superview.frame = frame;
//            self.view.height = self.view.superview.height;
//            bottomView.bottom = self.view.bottom;
//        }
//    }
//}

//ios 7 适配问题
- (void) viewDidLayoutSubviews {
    if (iOS7_OR_LATER) {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
    
    bottomView.bottom = self.view.bottom-64;
}

- (IBAction)tapAction:(id)sender {
    
    static BOOL hide = YES;
    self.navigationController.navigationBar.hidden = hide;
//    [self.navigationController setNavigationBarHidden:hide animated:YES];
    hide = !hide;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
