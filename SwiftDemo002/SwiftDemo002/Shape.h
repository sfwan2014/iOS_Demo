//
//  Shape.h
//  SwiftDemo002
//
//  Created by sfwan on 14-6-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

@interface Shape : NSObject
{
    NSString *_name;
    CGFloat _area;
    CGFloat _perimeter;
}
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign) CGFloat area;
@property (nonatomic, assign) CGFloat perimeter;

@end
