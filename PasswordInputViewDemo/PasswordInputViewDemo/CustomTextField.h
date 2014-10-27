//
//  CustomTextField.h
//  PasswordInputViewDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property (nonatomic, copy) NSMutableString *password;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) BOOL showPassword;

@end
