//
//  CircleView.h
//  CircleProgressView
//
//  Created by nieyun on 14-1-26.
//  Copyright (c) 2014年 changjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ROUND  @"round"
#define CIRCLE  @"circle"

@interface CircleView : UIView
{
    CAShapeLayer  *layer;
    UIView  *testView;
    CAKeyframeAnimation  *roundAnimation ;
    CABasicAnimation  *circleAnimation;
}
@property  (nonatomic,strong) UIImageView  *centerView;
//@property  (nonatomic,assign)  float  duaration;
//@property  (nonatomic,assign)  float   speed;
@end
