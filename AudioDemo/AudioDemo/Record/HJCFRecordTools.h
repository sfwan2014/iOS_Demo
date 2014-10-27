//
//  HJCFRecordTools.h
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCFRecordTools : NSObject

+(NSString *)fileName:(NSString *)name fileType:(NSString *)type;

+(NSArray *)allAudioFilesInCacheDirectory;

+(NSString *)audioFilePathFromFileName:(NSString *)fileName;

+(BOOL)deleteAudioForKey:(NSString *)fileName;

+(void)deleteAllAudio;

@end
