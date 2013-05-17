//
//  PPAudioPlayer.m
//  JennyJones
//
//  Created by Zune Moe on 17/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPAudioPlayer.h"

@implementation PPAudioPlayer

@synthesize repeats = _repeats;
@synthesize audioFile = _audioFile;
@synthesize volume = _volume;
@synthesize sendNotification = _sendNotification;

-(void) setRepeats:(BOOL)repeats
{
    _repeats = repeats;
    if (repeats) self.audioPlayer.numberOfLoops = -1;
    else self.audioPlayer.numberOfLoops = 0;
}

-(void)setVolume:(float)volume
{
    self.audioPlayer.volume = volume;
    _volume = volume;
} 

-(void) setAudioFile:(NSString *)audioFile
{
    _audioFile = audioFile;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],audioFile]];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	self.audioPlayer.delegate = self;
}

-(id)initWithAudioFile:(NSString*)audioFleName repeats:(BOOL)doesRepeat
{
    if (self = [super init]){
        self.fileName = audioFleName;
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],audioFleName]];
        
        NSError *error;
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
		self.audioPlayer.delegate = self;
        if (doesRepeat)
            self.audioPlayer.numberOfLoops = -1;
        else self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.volume = 1.0;
        [self.audioPlayer prepareToPlay];
        
    }
    return self;
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	if (self.sendNotification)
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

-(void) play
{
    [self.audioPlayer play];
}

-(void) stop
{
    [self.audioPlayer stop];
}

-(BOOL) isPlaying
{
    return [self.audioPlayer isPlaying];
}

@end
