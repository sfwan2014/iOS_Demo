//
//  ChartLineView.m
//  ChartDemo
//
//  Created by sfwan on 14-7-7.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ChartLineView.h"
#import "ChartCoordinateView.h"
#import "ChartFillView.h"

@interface ChartLineView ()<ChartCoordinateViewDataSource>

@end

@implementation ChartLineView
{
    ChartFillView *fillview;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    ChartCoordinateView *coordinateView = [[ChartCoordinateView alloc] initWithFrame:self.bounds];
    coordinateView.dataSource = self;
    coordinateView.lineColor = [UIColor blueColor];
    [self addSubview:coordinateView];
    
    fillview = [[ChartFillView alloc] initWithFrame:CGRectMake(40, 100-20, 40, 100)];
    [self addSubview:fillview];
    fillview.backgroundColor = [UIColor purpleColor];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}

-(void)timeAction:(NSTimer *)time
{
    static CGFloat h = 0;
//    fillview.trackLayer.timeOffset = MIN(1.0, t);
    [fillview setTrack:h];
          
    h += 0.1;
}

-(NSString *)chartCoordinateViewRowTitle:(ChartCoordinateView *)coordinateView
{
    return @"行标题";
}

-(NSString *)chartCoordinateViewColumnsTitle:(ChartCoordinateView *)coordinateView
{
    return @"列标题";
}

-(NSInteger)chartCoordinateViewRows:(ChartCoordinateView *)coordinateView
{
    return _rowData.count;
}

-(NSInteger)chartCoordinateViewColumns:(ChartCoordinateView *)coordinateView
{
    return _coluData.count;
}

-(NSString *)chartCoordinateViewRowSubTitle:(ChartCoordinateView *)coordinateView inRow:(NSInteger)row
{
    return _rowData[row];
}
-(NSString *)chartCoordinateViewColumnsSubTitle:(ChartCoordinateView *)coordinateView inColumn:(NSInteger)column
{
    return _coluData[column];
}

@end
