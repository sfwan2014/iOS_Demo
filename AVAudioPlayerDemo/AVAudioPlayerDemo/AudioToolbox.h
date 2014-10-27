//
//  AudioToolbox.h
//  AVAudioPlayerDemo
//
//  Created by sfwan on 14-8-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioToolbox : NSObject

//-(id)initWithURL:(NSURL *)URL;
// 播放方法定义
-(void)play:(CFURLRef)path;
// 缓存数据读取方法
-(void)audioQueueOutputWithQueue:(AudioQueueRef)audioQueue queueBuffer:(AudioQueueBufferRef)audioQueueBuffer;
// 定义回调(call back)函数
//static void BufferCallBack(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef buffer);
// 定义包数据的读取方法
-(UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer;
@end
