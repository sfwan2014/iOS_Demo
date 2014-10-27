//
//  AddViewController.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
@property (nonatomic, copy) NSString *MCC;

@property (retain, nonatomic) IBOutlet UITextField *typeNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *clsNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *MCCTextField;
@property (retain, nonatomic) IBOutlet UITextField *shopTypeTextField;
@property (retain, nonatomic) IBOutlet UITextField *rateTextField;
- (IBAction)addAction:(id)sender;
@end
