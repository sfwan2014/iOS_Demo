//
//  UIView+MDXibView.h
//  FinancialManageClient
//
//  Created by sfwan on 14-12-15.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MDXibView)
+(UIView *)loadViewWithNibName:(NSString *)nibName;
-(UIViewController *)viewController;
@end
