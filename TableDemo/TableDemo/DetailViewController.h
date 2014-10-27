//
//  DetailViewController.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, copy) NSString *MCC;
@property (retain, nonatomic) IBOutlet UITextField *idTextField;

@property (retain, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *clsNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *MCCLabel;
@property (retain, nonatomic) IBOutlet UILabel *shopType;
@property (retain, nonatomic) IBOutlet UILabel *rateLabel;

- (IBAction)findAction:(id)sender;
@end
