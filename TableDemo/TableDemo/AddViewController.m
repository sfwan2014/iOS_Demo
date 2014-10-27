//
//  AddViewController.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "AddViewController.h"
#import "Model.h"
#import "DBManager.h"
#import "BaseDBManager.h"
#import <CoreData/CoreData.h>

@interface AddViewController ()

@end

@implementation AddViewController

- (void)dealloc
{
    
    [super dealloc];
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
        Model *model = [BaseDBManager findModelById:_MCC];
        self.typeNameTextField.text = model.typeName;
        self.clsNameTextField.text = model.clsName;
        self.MCCTextField.text = model.iDMCC;
        self.shopTypeTextField.text = model.shopType;
        self.rateTextField.text = model.rate;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(id)sender {
    
    NSArray *allModels = [BaseDBManager findAllModels];
    for (Model *model in allModels) {
        if ([self.MCCTextField.text isEqualToString:model.iDMCC]) {
            
            model.typeName = _typeNameTextField.text;
            model.clsName = _clsNameTextField.text;
            model.iDMCC = _MCCTextField.text;
            model.shopType = _shopTypeTextField.text;
            model.rate = _rateTextField.text;
            
            [BaseDBManager editModel:model];
            
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    NSManagedObjectContext *managedObjectContextt = [DBManager defaultDBManager].managedObjectContext;
    Model *model = [NSEntityDescription insertNewObjectForEntityForName:@"Model" inManagedObjectContext:managedObjectContextt];
    model.typeName = _typeNameTextField.text;
    model.clsName = _clsNameTextField.text;
    model.iDMCC = _MCCTextField.text;
    model.shopType = _shopTypeTextField.text;
    model.rate = _rateTextField.text;
    
    [BaseDBManager addModel:model];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
