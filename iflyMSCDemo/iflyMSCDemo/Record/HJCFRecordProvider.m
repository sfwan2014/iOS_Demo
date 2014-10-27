//
//  HJCFRecordProvider.m
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFRecordProvider.h"
#import "HJCFRecordTools.h"

@interface HJCFRecordProvider ()<
AVAudioRecorderDelegate,
AVAudioPlayerDelegate,
AVAudioSessionDelegate>
@property (nonatomic, strong) AVAudioSession *audioSession;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSURL *recordedTmpFile;
@property (nonatomic, strong) AVAudioPlayer * avPlayer;


@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, assign) NSUInteger channels;

@end

@implementation HJCFRecordProvider

+(HJCFRecordProvider *)shareInstance
{
    static HJCFRecordProvider *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (instance == nil) {
            instance = [[HJCFRecordProvider alloc] init];
        }
    });
    
    return instance;
}

-(void)safetyReleaseRecorder
{
    if ([_recorder respondsToSelector:@selector(stop)]) {
        [_recorder stop];
    }
    _recorder = nil;
}

-(void)safetyReleasePlayer
{
    if ([_avPlayer respondsToSelector:@selector(stop)]) {
        [_avPlayer stop];
    }
    _avPlayer = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.audioSession = [AVAudioSession sharedInstance];
        NSError *error = nil;
        [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        [self.audioSession setActive:YES error:&error];
    }
    return self;
}

-(NSMutableDictionary *)recordSetting{
    NSMutableDictionary *recordSetting = [NSMutableDictionary dictionary];
    
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //    [recordSetting setValue:[NSNumber numberWithFloat:_rate] forKey:AVSampleRateKey];
    //    [recordSetting setValue:[NSNumber numberWithInt: _channels] forKey:AVNumberOfChannelsKey];
    
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    return recordSetting;
}

-(BOOL)startRecordAudio
{
    
    NSMutableDictionary *recordSetting = [self recordSetting];
    NSMutableString *fileName = [[HJCFRecordTools fileName:[NSString stringWithFormat:@"%@", [NSDate date]] fileType:@"wav"] mutableCopy];
    fileName = [[fileName stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];

    NSString *filePath = [HJCFRecordTools audioFilePathFromFileName:fileName];
    _recordedTmpFile = [NSURL fileURLWithPath:filePath];
    NSLog(@"Using File called: %@",_recordedTmpFile);
    
    NSError *error = nil;
    [self safetyReleaseRecorder];
    _recorder = [[ AVAudioRecorder alloc] initWithURL:_recordedTmpFile settings:recordSetting error:&error];
    
    [_recorder setDelegate:self];
    [_recorder prepareToRecord];
    return [_recorder record];
}

-(void)stopRecord
{
    [_recorder stop];
}

-(void)playRecordAudio
{
    [self playRecordAudio:_recordedTmpFile];
}

-(void)playRecordAudio:(NSURL *)url
{
    NSError *error = nil;
    [self safetyReleasePlayer];
    self.avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _avPlayer.delegate = self;
    [_avPlayer prepareToPlay];
    [_avPlayer play];
}

-(void)stopPlayeAudio
{
    if ([_avPlayer respondsToSelector:@selector(stop)]) {
        [_avPlayer stop];
    }
    self.avPlayer = nil;
}

#pragma mark - AVAudioPlayer delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        self.avPlayer = nil;
    }
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{

}

#pragma mark - AVAudioRecorder delegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{

}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    
}
// 中断回调
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{

}







@end
