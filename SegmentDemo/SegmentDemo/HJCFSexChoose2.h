//
//  HJCFSexChoose2.h
//  FinancialManage
//
//  Created by Lee on 14-8-11.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCFSexChoose2 : UIControl

@property (nonatomic, assign) NSInteger selectedIndex;
- (id)initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector;
-(void)addTarget:(id)target action:(SEL)action;
@end
