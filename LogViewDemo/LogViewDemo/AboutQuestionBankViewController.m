//
//  QuestionBankViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-6-30.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AboutQuestionBankViewController.h"

@interface AboutQuestionBankViewController ()

@end

@implementation AboutQuestionBankViewController

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
    
    self.title = @"关于题库";

    self.view.backgroundColor = RGB(226, 226, 226);
}

-(void)_initNavgationItems
{
    [self initBackItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
