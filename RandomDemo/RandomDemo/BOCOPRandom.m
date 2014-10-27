//
//  BOCOPRandom.m
//  RandomDemo
//
//  Created by shaofa on 14-4-10.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "BOCOPRandom.h"

@implementation BOCOPRandom

+(NSString *)createRandom
{
    int random1 = arc4random()%10;
    int random2 = arc4random()%10;
    int random3 = arc4random()%10;
    int random4 = arc4random()%10;
    int random5 = arc4random()%10;
    int random6 = arc4random()%10;
    NSString *randomStr = [NSString stringWithFormat:@"%d%d%d%d%d%d", random1, random2, random3, random4, random5, random6];
    NSLog(@"%@", randomStr);
    
    return randomStr;
}

@end
