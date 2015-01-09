//
//  UIView+MDXibView.m
//  FinancialManageClient
//
//  Created by sfwan on 14-12-15.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "UIView+MDXibView.h"

@implementation UIView (MDXibView)
+(UIView *)loadViewWithNibName:(NSString *)nibName{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    
    return view;
}

-(UIViewController *)viewController{
    UIResponder *nextResponder = [self nextResponder];
    while (![nextResponder isKindOfClass: [UIViewController class]]) {
        nextResponder = nextResponder.nextResponder;
    }
    
    return (UIViewController *)nextResponder;
}

@end
