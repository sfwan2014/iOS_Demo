//
//  AudioToolbox.m
//  AVAudioPlayerDemo
//
//  Created by sfwan on 14-8-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AudioToolbox.h"

void aa(
         void *						inClientData,
         AudioFileStreamID			inAudioFileStream,
         AudioFileStreamPropertyID	inPropertyID,
         UInt32 *					ioFlags)
{

}

void bb(
         void *							inClientData,
         UInt32							inNumberBytes,
         UInt32							inNumberPackets,
         const void *					inInputData,
         AudioStreamPacketDescription	*inPacketDescriptions)
{
    
}

void outPut(
              void *                  inUserData,
              AudioQueueRef           inAQ,
              AudioQueueBufferRef     inBuffer)
{

}

#define NUM_BUFFERS 3

@interface AudioToolbox ()

// 播放方法定义
//-(void)play:(CFURLRef)path;
// 缓存数据读取方法
//-(void)audioQueueOutputWithQueue:(AudioQueueRef)audioQueue queueBuffer:(AudioQueueBufferRef)audioQueueBuffer;
// 定义回调(call back)函数
static void BufferCallBack(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef buffer);
// 定义包数据的读取方法
//-(UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer;

@end

static UInt32 gBufferSizeBytes = 0x10000;

@implementation AudioToolbox
{
    NSURL *_url;
    // 音频流描述对象
    AudioFileID audioFile;
    // 音频流描述对象
    AudioStreamBasicDescription dataFormat;
    // 音频队列
    AudioQueueRef queue;
    
    SInt64 packetIndex;
    UInt32 numPacketsToRead;
    UInt32 bufferByteSize;
    AudioStreamPacketDescription *packetDescs;
    AudioQueueBufferRef buffers[NUM_BUFFERS];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < NUM_BUFFERS; i++) {
            AudioQueueEnqueueBuffer(queue, buffers[i], 0, nil);
        }
    }
    return self;
}


// 播放方法定义
-(void)play:(CFURLRef)path
{
    UInt32 size, maxPacketsSize;
    char *cookie;
//    int i;
    OSStatus status;
    
    // 打开音频文件
    status = AudioFileOpenURL(path, kAudioFileReadPermission, 0, &audioFile);
    if (status != noErr) {
        // 错误处理
        return;
    }
    
    // 取得音频数据格式
    size = sizeof(dataFormat);
    AudioFileGetProperty(audioFile, kAudioFilePropertyDataFormat, &size, &dataFormat);
    
    // 创建播放用的音频队列
    AudioQueueNewOutput(&dataFormat, BufferCallBack, (__bridge void *)(self), nil, nil, 0, &queue);
    
    // 计算单位时间包含的包数
    if (dataFormat.mBytesPerPacket == 0 || dataFormat.mFramesPerPacket == 0) {
        size = sizeof(maxPacketsSize);
        AudioFileGetProperty(audioFile, kAudioFilePropertyPacketSizeUpperBound, &size, &maxPacketsSize);
        if (maxPacketsSize > gBufferSizeBytes) {
            maxPacketsSize = gBufferSizeBytes;
        }
        // 算出单位时间内含的包数
        numPacketsToRead = gBufferSizeBytes/maxPacketsSize;
        packetDescs = malloc(sizeof(AudioStreamPacketDescription)*numPacketsToRead);
    } else {
        numPacketsToRead = gBufferSizeBytes/dataFormat.mBytesPerPacket;
        packetDescs = nil;
    }
    
    // 设置Magic Cookie
    AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyMagicCookieData, &size, nil);
    if (size > 0) {
        cookie = malloc(sizeof(char)*size);
        AudioFileGetProperty(audioFile, kAudioFilePropertyMagicCookieData, &size, cookie);
        AudioQueueSetProperty(queue, kAudioFilePropertyMagicCookieData, cookie, size);
        free(cookie);
    }
    
    // 创建并分配缓存空间
    packetIndex = 0;
    for (int i = 0; i < NUM_BUFFERS; i++) {
        AudioQueueAllocateBuffer(queue, gBufferSizeBytes, &buffers[i]);
        // 读取包数据
        if ([self readPacketsIntoBuffer:buffers[i]] == 0) {
            break;
        }
    }
    
    Float32 gain = 1.0;
    // 设置音量
    AudioQueueSetParameter(queue, kAudioQueueParam_Volume, gain);
    // 设置声道
    Float32 pan = -1.0;
    AudioQueueSetParameter(queue, kAudioQueueParam_Pan, pan);
    // 开始处理队列, 此后系统自动调用回调(CallBack)函数
    AudioQueueStart(queue, nil);
}   

// 缓存数据读取方法
-(void)audioQueueOutputWithQueue:(AudioQueueRef)audioQueue queueBuffer:(AudioQueueBufferRef)audioQueueBuffer
{
    OSStatus status;
    // 读取包数据
    UInt32 numBytes;
    UInt32 numPackets = numPacketsToRead;
    status = AudioFileReadPackets(audioFile, NO, &numBytes, packetDescs, packetIndex, &numPackets, audioQueueBuffer->mAudioData);
    
    //成功读取
    if (numPackets > 0) {
        // 将缓冲的容量设置为与读取的音频数据一样大小(确保内存空间)
        audioQueueBuffer->mAudioDataByteSize = numBytes;
        // 完成给队列配置缓存的处理
        status = AudioQueueEnqueueBuffer(audioQueue, audioQueueBuffer, numPackets, packetDescs);
        
        // 移动包的位置
        packetIndex += numPackets;
    }
}

// 定义回调(call back)函数
static void BufferCallBack(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef buffer)
{
    AudioToolbox *toolbox = (__bridge AudioToolbox *)inUserData;
    [toolbox audioQueueOutputWithQueue:inAQ queueBuffer:buffer];
}

// 定义包数据的读取方法
-(UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer
{
    //从文件中接受包数据并保存到缓存(buffer)
    UInt32 numByte, numPackets;
    numPackets = numPacketsToRead;
    AudioFileReadPackets(audioFile, NO, &numByte, packetDescs, packetIndex, &numPackets, buffer->mAudioData);
    if (numPackets > 0) {
        buffer->mAudioDataByteSize = numByte;
        AudioQueueEnqueueBuffer(queue, buffer, (packetDescs?numPackets:0), packetDescs);
        packetIndex += numPackets;
    }
    return numPackets;
}

@end
