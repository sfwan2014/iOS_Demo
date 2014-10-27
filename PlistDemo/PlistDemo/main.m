//
//  main.m
//  PlistDemo
//
//  Created by shaofa on 14-3-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        //获取沙盒路径
        NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *fileName = [paths objectAtIndex:0];
        
        // 数据持久化一  plist
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (int i = 0; i < 50; i++) {
            NSString *item = [NSString stringWithFormat:@"item%d", i];
            NSString *key = [NSString stringWithFormat:@"key%d", i];
            [dict setObject:item forKey:key];
        }
        NSString *filePath = @"/Users/issuser/Desktop/music/test.plist";
        if ([dict writeToFile:filePath atomically:YES]) {
            NSLog(@"success");
        }
        
        // 数据持久化二  xml
        filePath = @"/Users/issuser/Desktop/music/test.xml";
        if ([dict writeToFile:filePath atomically:YES]) {
            NSLog(@"success");
        }

        NSDictionary *readDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSLog(@"%@", readDict);
        
        
        


    }
    return 0;
}

