//
//  CustomTabBarItem.m
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomTabBarItem.h"

@implementation CustomTabBarItem

- (id)initWithFrame:(CGRect)frame
             target:(id)target
             action:(SEL)selector
               type:(UIButtonType)type
              title:(NSString *)title
          normImage:(UIImage *)normImage
      selectedImage:(UIImage *)selectedImage
{
    self = [CustomTabBarItem buttonWithType:type];
    if (self) {
        self.frame = frame;
        [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self setTitle:title forState:UIControlStateNormal];
//        [self setImage:normImage forState:UIControlStateNormal];
        [self setBackgroundImage:normImage forState:UIControlStateNormal];
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    return self;
}


@end
