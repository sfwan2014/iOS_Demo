//
//  Tools.m
//  NSKeyedArchiverDemo
//
//  Created by shaofa on 14-3-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "Tools.h"
#import "SFBaseModel.h"

@implementation Tools

+(void)archiver:(NSArray *)array
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:array forKey:@"kArray"];
    [archiver finishEncoding];
    [archiver release];
    [data writeToFile:[self filePath:@"data.zz"] atomically:YES];
}

+(NSArray *)unArchiver
{
    NSMutableData *data2 = [NSMutableData dataWithContentsOfFile:[self filePath:@"data.zz"]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data2];
    
    NSArray *array = [unarchiver decodeObjectForKey:@"kArray"];
    [unarchiver finishDecoding];
    [unarchiver release];
    return array;
}

+(NSString *)filePath:(NSString *)fileName
{
    //获取沙盒路径
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *resourcePath = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", resourcePath, fileName];
    return filePath;
}

@end
