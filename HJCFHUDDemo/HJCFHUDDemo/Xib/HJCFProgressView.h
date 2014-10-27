//
//  HJCFProgressView.h
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFXibView.h"

@interface HJCFProgressView : HJCFXibView

@property(nonatomic, strong)UIColor *trackColor;
@property(nonatomic, strong)UIColor *progressColor;

@property (nonatomic, assign) CGFloat progress; // 大于0 小于1
@property(nonatomic, assign)float progressWidth;

-(void)setProgress:(float)progress animated:(BOOL)animated;
@end
