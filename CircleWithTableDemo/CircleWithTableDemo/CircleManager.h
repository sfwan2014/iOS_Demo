//
//  CircleManager.h
//  CircleWithTableDemo
//
//  Created by sfwan on 14-12-27.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CDCircle.h"
#import "Common.h"
#import "CDCircleThumb.h"
#import "CDCircleGestureRecognizer.h"

@interface CircleManager : NSObject
+(CircleManager *)shareManager;

@property (nonatomic, assign) BOOL startDrag;
@property (nonatomic, assign) NSInteger isLocation;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) CDCircle *circle;

-(NSArray *)rotations;

-(CGFloat)scrollView:(UIScrollView *)scrollView scrollTo:(CGFloat)y;
-(CGFloat)scrollView:(UIScrollView *)scrollView scrollUpBorder:(CGFloat)y;
-(CGFloat)scrollView:(UIScrollView *)scrollView scrollDownBorder:(CGFloat)y;
-(void)scrollViewDidEndScroll:(UIScrollView *)scrollView;


// 圆
-(void)setScrollView:(UIScrollView *)scrollView scrollToIndex:(CGFloat)index;
-(CGFloat)scrollView:(UIScrollView *)scrollView scrollWithAngle:(CGFloat)angle;
-(BOOL)scrollView:(UIScrollView *)scrollView scrollWithRotation:(CGFloat)rotation;

@end
