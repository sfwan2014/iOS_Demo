//
//  CustomTabBarItem.h
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UIButton
- (id)initWithFrame:(CGRect)frame
             target:(id)target
             action:(SEL)selector
               type:(UIButtonType)type
              title:(NSString *)title
          normImage:(UIImage *)normImage
      selectedImage:(UIImage *)selectedImage;
@end
