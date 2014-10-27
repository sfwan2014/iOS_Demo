//
//  ChartFillView.h
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartFillView : UIView
-(void)addAnimation;
-(void)setTrack:(CGFloat)height;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@end
