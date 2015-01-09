//
//  CALayer+Addition.m
//  FinancialIPAD
//
//  Created by Edmond on 10/31/13.
//  Copyright (c) 2013 CYTX. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)
@dynamic tag;

- (void)resizeHeightBy:(CGFloat)values
{
    CGPoint point = self.bounds.origin;
    CGSize size = self.bounds.size;
    self.bounds = CGRectMake(point.x, point.y, size.width, size.height + values);
}

- (void)resizeWidthBy:(CGFloat)values
{
    CGPoint point = self.bounds.origin;
    CGSize size = self.bounds.size;
    self.bounds = CGRectMake(point.x, point.y, size.width + values, size.height);
}

- (void)pauseAnimation:(CALayer *)layer{
    layer.speed = 0.0f;     // 让baselayer的绘图动作停止；
    layer.timeOffset =      //记录一个默认时间；这里保存取到的停止时间；
    [layer convertTime:CACurrentMediaTime() fromLayer:nil];
}

- (void)startAnimationWithLayer:(CALayer *)layer
{
    layer.speed = 1.0f;             //恢复绘图
    layer.timeOffset = 0.0f;
    layer.beginTime = 0.0f;         //
    CFTimeInterval sincePause =
    [layer convertTime:CACurrentMediaTime() fromLayer:nil] + 2.0f;
    layer.beginTime = sincePause + 1.0f;
}

- (CALayer *)layerWithTag:(NSInteger)tag
{
    for (CALayer *subLayer in self.sublayers) {
        if (subLayer.tag == tag) {
            return subLayer;
        }
    }
//    FWLOG(LOG_TRUE, @"%@ DONT HAVE SUB LAYERS", NSStringFromClass([self class]));
    return nil;
}

//- (void)setLayerImage:(NSString *)imageName
//{
//    UIImage *img = [UIImage imageNamed:imageName];
//    self.contents = (id)img.CGImage;
//    self.anchorPoint = POINT(0, 0);
//    self.bounds = RECT(0, 0, img.size.width, img.size.height);
//}

@end







