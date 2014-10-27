//
//  HJCFRecordTools.m
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFRecordTools.h"

@implementation HJCFRecordTools

// 获取所有文件名
+(NSArray *)allAudioFilesInCacheDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = Nil;
    return [fm contentsOfDirectoryAtPath:[self audioCacheDirectory] error:&error];
}

// 删除所有的音频文件
+(void)deleteAllAudio
{
    NSArray *audios = [self allAudioFilesInCacheDirectory];
    for (NSString *fileName in audios) {
        [self deleteAudioForKey:fileName];
    }
}

// 删除指定名字的文件
+(BOOL)deleteAudioForKey:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *filePath = [self audioFilePathFromFileName:fileName];
    return [fm removeItemAtPath:filePath error:nil];
}

// 获取文件所在路径
+(NSString *)audioFilePathFromFileName:(NSString *)fileName
{
    NSString *cacheDirectory = [self audioCacheDirectory];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:cacheDirectory]) {
        [fm createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:Nil];
    }
    
    return [cacheDirectory stringByAppendingPathComponent:fileName];
}

// 获取文件所在目录
+(NSString *)audioCacheDirectory
{
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, \
                                                 NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[self audioCacheSubCacheDirectory]];
}

// 获取子目录
+(NSString *)audioCacheSubCacheDirectory
{
    return @"/UserInfo/Voice";
}

// 获取文件名
+(NSString *)fileName:(NSString *)name fileType:(NSString *)type
{
    return [NSString stringWithFormat:@"%@.%@", name, type];
}

@end
