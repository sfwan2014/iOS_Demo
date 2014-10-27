//
//  ITTShapeLayer.m
//  CAAnimationDemo
//
//  Created by shaofa on 14-5-22.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ITTShapeLayer.h"

@implementation ITTShapeLayer

-(Class)layerClass
{
    return [CAShapeLayer class];
}

-(CAShapeLayer *)shapeLayer
{
    return ((CAShapeLayer *)self.layer);
}

@end
