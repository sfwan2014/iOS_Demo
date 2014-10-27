//
//  QuestionFeedbackViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-30.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "QuestionFeedbackViewController.h"

@interface QuestionFeedbackViewController ()

@end

@implementation QuestionFeedbackViewController

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
    
    self.title = @"问题反馈";

    self.view.backgroundColor = RGB(226, 226, 226);
}


-(void)_initNavgationItems
{
    [self initBackItem];
}
- (IBAction)confirmBtnAction:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
