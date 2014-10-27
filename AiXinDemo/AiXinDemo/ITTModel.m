//
//  ITTModel.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ITTModel.h"

@implementation ITTModel

- (id)init
{
    self = [super init];
    if (self) {
        NSString *s;
        [s compare:s];
    }
    return self;
}

- (NSComparisonResult)compareNum1:(ITTModel *)model
{
    
    if (self.isUp ? (self.number1 > model.number1) : (self.number1 < model.number1)) {
        
        return NSOrderedDescending;
    } else if (self.number1 == model.number1) {
        
        return NSOrderedSame;
    }else {
        return NSOrderedAscending;
    }
}

- (NSComparisonResult)compareNum2:(ITTModel *)model
{
    
    if (self.isUp ? (self.number2 > model.number2) : (self.number2 < model.number2)) {
        
        return NSOrderedDescending;
    } else if (self.number2 == model.number2) {
        
        return NSOrderedSame;
    }else {
        return NSOrderedAscending;
    }
}

- (NSComparisonResult)compareNum3:(ITTModel *)model
{
    
    if (self.isUp ? (self.number3 > model.number3) : (self.number3 < model.number3)) {
        
        return NSOrderedDescending;
    } else if (self.number3 == model.number3) {
        
        return NSOrderedSame;
    }else {
        return NSOrderedAscending;
    }
}

@end
