//
//  PPWatchView.m
//  JennyJones
//
//  Created by tommyogp on 26/10/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPWatchView.h"
#import "PPRotatingView.h"
#import "PPNumericView.h"
#import "PPWatchConfig.h"
#import <QuartzCore/QuartzCore.h>

@interface PPWatchView () <PPRotatingViewDelegate> {
    IBOutlet PPRotatingView *handContainer;
    IBOutlet PPRotatingView *cog1;
    IBOutlet PPRotatingView *cog2;
    IBOutlet PPRotatingView *cog3;
    IBOutlet PPRotatingView *cog4;
    
    IBOutlet UIView *springCountContainer;
    IBOutlet PPNumericView *countContainer;
    
    float countdownTimer;
    float totalTime;
	float countdownInterval;
}

@property (strong) AVAudioPlayer *countdownPlayerSlow;
@property (strong) AVAudioPlayer *countdownPlayerMid;
@property (strong) AVAudioPlayer *countdownPlayerFast;
@property (strong) AVAudioPlayer *countdownPlayerGong;

- (void) animateBounce:(UIView *) bouncingObj;
@end

@implementation PPWatchView

@synthesize countdownPlayerSlow, countdownPlayerMid, countdownPlayerFast, countdownPlayerGong;

- (id)initWatchView{
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"PPWatchView"
                                                        owner:self
                                                      options:nil];
    self = [nibObjects objectAtIndex:0];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        springCountContainer.backgroundColor = [UIColor clearColor];
        countContainer.backgroundColor = [UIColor clearColor];
        
        CGRect frame = self.frame;
        frame.origin.x = 1024-frame.size.width;
        self.frame = frame;
        
        //handContainer.rpm = HAND_RPM;
        handContainer.delegate = self;
        
        cog1.rpm = COG1_RPM;
        cog2.rpm = COG2_RPM;
        cog3.rpm = COG3_RPM;
        cog4.rpm = COG4_RPM;
		
		NSURL *countdownSlowURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Countdown_slow.mp3", [[NSBundle mainBundle] resourcePath]]];
		NSURL *countdownMidURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Countdown_mid.mp3", [[NSBundle mainBundle] resourcePath]]];
		NSURL *countdownFastURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Countdown_fast.mp3", [[NSBundle mainBundle] resourcePath]]];
		NSURL *countdownGongURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Countdown_gongt.mp3", [[NSBundle mainBundle] resourcePath]]];
		
		NSError *error;
		
		self.countdownPlayerSlow = [[AVAudioPlayer alloc] initWithContentsOfURL:countdownSlowURL error:&error];
		self.countdownPlayerMid = [[AVAudioPlayer alloc] initWithContentsOfURL:countdownMidURL error:&error];
		self.countdownPlayerFast = [[AVAudioPlayer alloc] initWithContentsOfURL:countdownFastURL error:&error];
		self.countdownPlayerGong = [[AVAudioPlayer alloc] initWithContentsOfURL:countdownGongURL error:&error];
		
		self.countdownPlayerSlow.numberOfLoops = -1;
		self.countdownPlayerMid.numberOfLoops = -1;
		self.countdownPlayerFast.numberOfLoops = -1;
		
		[self.countdownPlayerSlow prepareToPlay];
		[self.countdownPlayerMid prepareToPlay];
		[self.countdownPlayerFast prepareToPlay];
		[self.countdownPlayerGong prepareToPlay];
		
		handContainer.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180);
         [countContainer setCurrentCount:self.currentCount];
    }
    return self;
}

- (void)startTimer:(float) interval{
#ifdef DEBUG_MODE
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    countdownTimer = interval;
    totalTime = interval;
    _timeTaken = interval;
    
	countdownInterval = countdownTimer / 3.0;
	
	handContainer.rpm = 60.0 / countdownTimer;
	handContainer.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180);
    [handContainer rotate];
    [cog1 rotate];
    [cog2 rotate];
    [cog3 rotate];
    [cog4 rotate];
}

- (void)stopTimer{
#ifdef DEBUG_MODE
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    [handContainer reset];
    [cog1 reset];
    [cog2 reset];
    [cog3 reset];
    [cog4 reset];
	
	[self.countdownPlayerSlow stop];
	[self.countdownPlayerMid stop];
	[self.countdownPlayerFast stop];
}

- (void)setCurrentCount:(NSUInteger)currentCount{
    _currentCount = currentCount;
    
    // not bounce again when already animating
    if (springCountContainer.layer.animationKeys.count == 0) {
        [self animateBounce:springCountContainer];
    }
    //[countContainer setCurrentCount:_currentCount];
}

- (void) animateBounce:(UIView *) bouncingObj{
    __block CGRect frame = bouncingObj.frame;
    
    float jiggleTime = 0.10;
    float jiggleDistance = 10;
    [UIView animateWithDuration:BOUNCE_DURATION delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        frame.origin.y -= BOUNCE_LENGTH;
        bouncingObj.frame = frame;
    }completion:^(BOOL finished) {
        [countContainer setCurrentCount:self.currentCount];
        [UIView animateWithDuration:BOUNCE_DURATION+jiggleTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             frame.origin.y += (BOUNCE_LENGTH+jiggleDistance);
                             bouncingObj.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:jiggleTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  frame.origin.y -= jiggleDistance;
                                                  bouncingObj.frame = frame;
                                              } completion:nil];
                         }];
    }];
}


#pragma mark -
- (void) didCompleteOneSecond{    
    countdownTimer --;
    _percent = countdownTimer / totalTime;
    _timeTaken ++;
	
	if (countdownTimer > countdownInterval * 2)
	{
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"])[self.countdownPlayerSlow play];
	}
	else [self.countdownPlayerSlow stop];
	
	if (countdownTimer > countdownInterval && countdownTimer <= countdownInterval * 2)
	{
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"])[self.countdownPlayerMid play];
	}
	else [self.countdownPlayerMid stop];
	
	if (countdownTimer <= countdownInterval)
	{
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"])[self.countdownPlayerFast play];
	}
	else [self.countdownPlayerFast stop];
	
    if (countdownTimer <= 0.0) {
        [self stopTimer];
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"])[self.countdownPlayerGong play];
		//handContainer.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180);
#ifdef DEBUG_MODE
        NSLog(@"timerDidExpire");
#endif
        [_delegate timerDidExpire:self];
    }
}

@end
