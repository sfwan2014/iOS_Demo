//
//  CustomItem.h
//  CustomButtonDemo
//
//  Created by sfwan on 14-7-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomItem : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) NSInteger tag;

-(id)initWithTitle:(NSString *)title tag:(NSInteger)tag;

@end
