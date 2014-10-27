//
//  CustomButton.h
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kItemWidth          30

@interface CustomButton : UIControl
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items target:(id)target selector:(SEL)selector;
@end
