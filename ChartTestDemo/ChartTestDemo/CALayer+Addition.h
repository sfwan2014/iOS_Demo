//
//  CALayer+Addition.h
//  FinancialIPAD
//
//  Created by Edmond on 10/31/13.
//  Copyright (c) 2013 CYTX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Addition)

@property (nonatomic, assign) int tag;


- (void)resizeHeightBy:(CGFloat)values;
- (void)resizeWidthBy:(CGFloat)values;

- (void)pauseAnimation:(CALayer *)layer;
- (void)startAnimationWithLayer:(CALayer *)layer;

- (CALayer *)layerWithTag:(NSInteger)tag;

/**
 *  创建以图片大小相同的层；
 **/
//- (void)setLayerImage:(NSString *)imageName;

@end
