//
//  HJCFSegment.h
//  SegmentControlDemo
//
//  Created by sfwan on 14-7-14.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCFSegment : UIControl

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *highlightColor;

- (id)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector;

@end
