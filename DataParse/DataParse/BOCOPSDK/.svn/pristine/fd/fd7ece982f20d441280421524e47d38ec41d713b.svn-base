//
//  NSArray+ITTAdditions.m
//
//  Created by guo hua on 11-9-21.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//

#import "NSArray+BOCOPAdditions.h"

@implementation NSArray(BOCOPAdditions)
-(BOOL)contentString:(NSString *)string{
    for (id object in self) {
        if ([object isKindOfClass:[NSString class]]&&[object isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

-(NSInteger)indexOfString:(NSString *)string{
    for (id object in self) {
        if ([object isKindOfClass:[NSString class]]&&[object isEqualToString:string]) {
            return [self indexOfObject:object];
        }
    }
    return NSNotFound;
}
@end
