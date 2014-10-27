//
//  EditViewController.h
//  TableDemo
//
//  Created by shaofa on 14-3-13.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property (nonatomic, copy) NSString *MCC;

@property (retain, nonatomic) IBOutlet UITextField *typeNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *clsNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *MCCTextField;
@property (retain, nonatomic) IBOutlet UITextField *shopTypeTextField;
@property (retain, nonatomic) IBOutlet UITextField *rateTextField;

- (IBAction)saveAction:(id)sender;

@end
