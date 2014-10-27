//
//  DetailViewController.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseDBManager.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    if (self.MCC.length > 0) {
        [self displaySubviews];
    }
}

-(void)hiddenKeyboard
{
    if ([self.idTextField becomeFirstResponder]) {
        [self.idTextField resignFirstResponder];
    }
}

-(void)displaySubviews
{
    Model *model = [BaseDBManager findModelById:_MCC];
    self.typeNameLabel.text = model.typeName;
    self.clsNameLabel.text = model.clsName;
    self.MCCLabel.text = model.iDMCC;
    self.shopType.text = model.shopType;
    self.rateLabel.text = model.rate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_typeNameLabel release];
    [_clsNameLabel release];
    [_MCCLabel release];
    [_shopType release];
    [_rateLabel release];
    [_idTextField release];
    [super dealloc];
}
- (IBAction)findAction:(id)sender {
    
    NSString *MCC = self.idTextField.text;
    
    if (MCC.length != 15) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入15位数的单号!" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
        [alert show];
        
        [alert release];
        return;
    }
    
    NSRange range = NSMakeRange(8, 4);
    NSString *subMCC = [MCC substringWithRange:range];
    
    self.MCC = subMCC;
    
    [self hiddenKeyboard];
    
    [self displaySubviews];
}
@end
