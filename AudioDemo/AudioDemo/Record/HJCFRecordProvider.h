//
//  HJCFRecordProvider.h
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface HJCFRecordProvider : NSObject

+(HJCFRecordProvider *)shareInstance;

-(void)stopRecord;
-(BOOL)startRecordAudio;

-(void)playRecordAudio;
-(void)stopPlayeAudio;
-(void)playRecordAudio:(NSURL *)url;

-(void)wavToAmrWithArmFileName:(NSString *)fileName;

@end
