//
//  LineChartView.h
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChartCoordinateView;
@protocol ChartCoordinateViewDataSource <NSObject>

@optional
-(NSInteger)chartCoordinateViewRows:(ChartCoordinateView *)coordinateView;
-(NSInteger)chartCoordinateViewColumns:(ChartCoordinateView *)coordinateView;

-(NSString *)chartCoordinateViewRowTitle:(ChartCoordinateView *)coordinateView;
-(NSString *)chartCoordinateViewColumnsTitle:(ChartCoordinateView *)coordinateView;

-(NSString *)chartCoordinateViewRowSubTitle:(ChartCoordinateView *)coordinateView inRow:(NSInteger)row;
-(NSString *)chartCoordinateViewColumnsSubTitle:(ChartCoordinateView *)coordinateView inColumn:(NSInteger)column;

@end

@interface ChartCoordinateView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) id<ChartCoordinateViewDataSource>dataSource;

@end
