//
//  EditViewController.m
//  TableDemo
//
//  Created by shaofa on 14-3-13.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "EditViewController.h"
#import "Model.h"
#import "DBManager.h"
#import "BaseDBManager.h"

@interface EditViewController ()

@end

@implementation EditViewController
{
    Model *_model;
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

    [self _displayOriginalData];
}

-(void)_displayOriginalData
{
    if (_MCC.length > 0) {
        
        self.MCCTextField.enabled = NO;
        _model = [BaseDBManager findModelById:_MCC];
        self.typeNameTextField.text = _model.typeName;
        self.clsNameTextField.text = _model.clsName;
        self.MCCTextField.text = _model.iDMCC;
        self.shopTypeTextField.text = _model.shopType;
        self.rateTextField.text = _model.rate;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    
    _model.typeName = _typeNameTextField.text;
    _model.clsName = _clsNameTextField.text;
    _model.iDMCC = _MCCTextField.text;
    _model.shopType = _shopTypeTextField.text;
    _model.rate = _rateTextField.text;
    
    [BaseDBManager editModel:_model];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
