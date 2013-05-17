//
//  PPAudioPlayer.h
//  JennyJones
//
//  Created by Zune Moe on 17/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PPAudioPlayer : NSObject <AVAudioPlayerDelegate>

@property (strong,nonatomic)NSString * fileName;
@property (strong,nonatomic)AVAudioPlayer * audioPlayer;
@property (nonatomic) BOOL repeats;
@property (nonatomic) NSString * audioFile;
@property (nonatomic) float volume;
@property BOOL sendNotification;

-(id)initWithAudioFile:(NSString*)audioFleName repeats:(BOOL)doesRepeat;

-(void) play;
-(void) stop;
-(BOOL) isPlaying;

@end
