//
//  SV15.m
//  JennyJones
//
//  Created by Zune Moe on 25/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV15.h"
#import <QuartzCore/QuartzCore.h>

@interface SV15 ()
{
    int songid;
    NSTimer *timer;
    float flip;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Song01;
@property (weak, nonatomic) IBOutlet UIImageView *Song02;
@property (weak, nonatomic) IBOutlet UIImageView *Song03;
@property (weak, nonatomic) IBOutlet UIImageView *Song04;
@property (weak, nonatomic) IBOutlet UIImageView *Song05;
@property (weak, nonatomic) IBOutlet UIImageView *Song06;
@property (weak, nonatomic) IBOutlet UIImageView *Mum01;
@property (weak, nonatomic) IBOutlet UIImageView *Dad01;
@property (weak, nonatomic) IBOutlet UIImageView *Boy01;
@property (weak, nonatomic) IBOutlet UIImageView *BoyB01;
@property (weak, nonatomic) IBOutlet UIImageView *Miao01;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV15

@synthesize defaults = _defaults;


- (IBAction)prevSongTapped:(UITapGestureRecognizer *)sender
{
	if (songid > 1) songid--;
    else songid = 6;
	
	switch (songid) {
        case 1:
            [self.SFX02 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
            
            self.Song02.hidden = YES;
            self.Song01.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:0.9];
            break;
        case 2:
            [self.SFX03 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
            
            self.Song03.hidden = YES;
            self.Song02.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:4];
            break;
        case 3:
            [self.SFX04 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
            
            self.Song04.hidden = YES;
            self.Song03.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration: 1.5];
            break;
        case 4:
            [self.SFX05 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
            
            self.Song05.hidden = YES;
            self.Song04.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:1];
            break;
        case 5:
            [self.SFX06 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
            
            self.Song06.hidden = YES;
            self.Song05.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:5];
            break;
        case 6:
            [self.SFX01 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX06 play];
            
            self.Song01.hidden = YES;
            self.Song06.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:3];
			break;
        default:
            break;
    }
}

- (IBAction)skipSongTapped:(UITapGestureRecognizer *)sender
{
	if (songid < 6) songid++;
    else songid = 1;
	
    switch (songid) {
        case 1:
            [self.SFX06 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
            
            self.Song06.hidden = YES;
            self.Song01.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:0.9];
            break;
        case 2:
            [self.SFX01 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
            
            self.Song01.hidden = YES;
            self.Song02.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:4];
            break;
        case 3:
            [self.SFX02 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
            
            self.Song02.hidden = YES;
            self.Song03.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration: 1.5];
            break;
        case 4:
            [self.SFX03 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
            
            self.Song03.hidden = YES;
            self.Song04.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:1];
            break;
        case 5:
            [self.SFX04 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
            
            self.Song04.hidden = YES;
            self.Song05.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:5];
            break;
        case 6:
            [self.SFX05 stop];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX06 play];
            
            self.Song05.hidden = YES;
            self.Song06.hidden = NO;
            
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:3];
			break;
        default:
            break;
    }
}

- (void) startTimer: (double) duration
{
    timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(loopMumTransform) userInfo:nil repeats:YES];
}

- (void) loopMumTransform
{
    if (flip == 1.0) flip = -1.0;
    else flip = 1.0;
    
    self.Mum01.transform = CGAffineTransformMakeScale(flip, 1.0);
}

- (void) familyStartAnimateWithDuration: (float) duration
{
    self.Dad01.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"15_Dad-01.png"],
                                  [UIImage imageNamed:@"15_Dad-02.png"],
                                  nil];
    self.Dad01.animationDuration = duration;
    self.Dad01.animationRepeatCount = HUGE_VALF;
    [self.Dad01 startAnimating];
    
    self.Boy01.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"15_BoyA-01.png"],
                                  [UIImage imageNamed:@"15_BoyA-02.png"],
                                  nil];
    self.Boy01.animationDuration = duration;
    self.Boy01.animationRepeatCount = HUGE_VALF;
    [self.Boy01 startAnimating];
    
    self.BoyB01.animationImages = [NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"15_BoyB-01.png"],
                                   [UIImage imageNamed:@"15_BoyB-02.png"],
                                   nil];
    self.BoyB01.animationDuration = duration;
    self.BoyB01.animationRepeatCount = HUGE_VALF;
    [self.BoyB01 startAnimating];
    
    self.Miao01.animationImages = [NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"15_Miao01.png"],
                                   [UIImage imageNamed:@"15_Miao02.png"],
                                   [UIImage imageNamed:@"15_Miao03.png"],
                                   nil];
    self.Miao01.animationDuration = duration;
    self.Miao01.animationRepeatCount = HUGE_VALF;
    [self.Miao01 startAnimating];
    
    [self startTimer:duration * 0.5];
}

- (void) familyStopAnimate
{
    [self.Dad01 stopAnimating];
    [self.Boy01 stopAnimating];
    [self.BoyB01 stopAnimating];
    [self.Miao01 stopAnimating];
    [timer invalidate];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer stop];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
		{
			[self.SFX01 stop];
			[self.SFX02 stop];
			[self.SFX03 stop];
			[self.SFX04 stop];
			[self.SFX05 stop];
			[self.SFX06 stop];
		}
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
			
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
		{
			switch (songid) {
				case 1:
					[self.SFX01 play];
					break;
				case 2:
					[self.SFX02 play];
					break;
				case 3:
					[self.SFX03 play];
					break;
				case 4:
					[self.SFX04 play];
					break;
				case 5:
					[self.SFX05 play];
					break;
				case 6:
					[self.SFX06 play];
					break;
				default:
					break;
			}
		}
	}
}

- (void) voiceoverPlayerFinishPlaying:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		self.btnNext.alpha = 1.0;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) appWillEnterForeground
{
	switch (songid) {
        case 1:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:0.9];
            break;
        case 2:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:4];
            break;
        case 3:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration: 1.5];
            break;
        case 4:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:1];
            break;
        case 5:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:5];
            break;
        case 6:
            [self familyStopAnimate];
            [self familyStartAnimateWithDuration:3];
			break;
        default:
            break;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"15_VO.mp3"];
    [self.SFX01 setAudioFile:@"15_Song01.mp3"];
    [self.SFX02 setAudioFile:@"15_Song02.mp3"];
    [self.SFX03 setAudioFile:@"15_Song03.mp3"];
    [self.SFX04 setAudioFile:@"15_Song04.mp3"];
    [self.SFX05 setAudioFile:@"15_Song05.mp3"];
    [self.SFX06 setAudioFile:@"15_Song06.mp3"];
    
    self.SFX01.repeats = YES;
    self.SFX02.repeats = YES;
    self.SFX03.repeats = YES;
    self.SFX04.repeats = YES;
    self.SFX05.repeats = YES;
    self.SFX06.repeats = YES;
    
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:28];
    
    flip = 1.0;
    
    [self familyStartAnimateWithDuration:0.9];
    songid = 1;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.BG = nil;
    self.Song01 = nil;
    self.Song02 = nil;
    self.Song03 = nil;
    self.Song04 = nil;
    self.Song05 = nil;
    self.Song06 = nil;
    self.Mum01 = nil;
    self.Dad01 = nil;
    self.Boy01 = nil;
    self.BoyB01 = nil;
    self.Miao01 = nil;
    self.Label = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
    self.SFX04 = nil;
    self.SFX05 = nil;
    self.SFX06 = nil;
    
    self.defaults = nil;
    timer = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
