//
//  FWTextLayer.h
//  FinancialIPAD
//
//
//  Created by Edmond on 11/1/13.
//  Copyright (c) 2013 CYTX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface FWTextLayer : CATextLayer

//  相对坐标为父视图左上角；
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *shadowColor;

//  文本的间距;
@property (nonatomic, assign) NSInteger maxDeflat;

/**
 *  创建自定义文本； font：带有字体名，字体size， text:文本内容; postion:位置；
 **/
- (void)setTextFont:(UIFont *)font text:(NSString *)text position:(CGPoint)position;

- (void)setTextFont:(UIFont *)font text:(NSString *)text;

- (void)setTextFont:(UIFont *)font;

- (void)setTextShadow;


- (void)setYDirectionAnimationWithCurrentPoint:(CGPoint)currentPoint;


@end
