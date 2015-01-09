//
//  DescriptLayer.h
//  ChartTestDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface DescriptLayer : CALayer
-(id)initWithFrame:(CGRect)frame color:(CGColorRef )color font:(UIFont *)font;
-(void)addMessages:(NSMutableDictionary *)message;
@property(nonatomic, strong, readonly)UIFont *font;;
@end
