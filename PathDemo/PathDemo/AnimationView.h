//
//  AnimationView.h
//  PathDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

@property (nonatomic, copy)NSString *imgName;
-(void)addAnimationToPoint:(CGPoint)point;
-(void)endAnimation;
-(void)backToOriginalPosition:(CGPoint)point;
@end
