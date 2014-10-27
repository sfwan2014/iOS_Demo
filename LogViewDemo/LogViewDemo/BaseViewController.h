//
//  BaseViewController.h
//  LogViewDemo
//
//  Created by sfwan on 14-6-25.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0  alpha:1]

@interface BaseViewController : UIViewController
-(void)initBackItem;
-(void)addBackgroundImageView;
-(void)addBackgroundImageViewWithImageName:(NSString *)imageName;
-(void)addKeyboardNotification;
@end
