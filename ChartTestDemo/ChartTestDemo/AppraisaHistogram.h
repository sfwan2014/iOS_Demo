//
//  SimpleHistogram.h
//  FinancialIPAD
//
//  Created by zsc on 13-12-30.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppraisaHistogram;
@protocol SimpleHistogramDelegate <NSObject>

-(void)simpleHistogramTap:(AppraisaHistogram *)histogram tapLayers:(NSArray *)layers selectedIndex:(NSInteger)index;

@end

@interface AppraisaHistogram : UIView
-(void) setData:(NSArray *) lineData  andBarColors:(NSArray *)colors andTitles:(NSArray *) titles andTitleColor:(UIColor*)titleColor andTitleFont:(UIFont*)titleFont;
-(void) setData:(NSArray *)lineData  andBarColors:(NSArray *)colors andTitles:(NSArray *) titles andTitleColors:(NSArray*)titleColors andTitleFont:(UIFont*)titleFont;
-(void)setData:(NSArray*) lineDatas;

-(void)setEdgeInsets:(UIEdgeInsets) edge;
-(void)hideVirtualLayer;

@property(nonatomic, assign) id<SimpleHistogramDelegate>tapDelegate;

@end
