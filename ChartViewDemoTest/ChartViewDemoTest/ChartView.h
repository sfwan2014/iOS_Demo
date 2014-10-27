//
//  ChartView.h
//  ChartViewDemoTest
//
//  Created by sfwan on 14-10-19.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView

@property (nonatomic, strong) NSDictionary *dataSource;

-(id)initWithFrame:(CGRect)frame dataSource:(NSDictionary *)dataSource axisYTitles:(NSArray *)aYTitles axisXTitles:(NSArray *)aXTitles;
@end
