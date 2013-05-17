//
//  SV03b.m
//  JennyJones
//
//  Created by Zune Moe on 14/5/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV03b.h"

@interface SV03b ()

@property (weak, nonatomic) IBOutlet UILabel *Labelb;
@property (weak, nonatomic) IBOutlet UIImageView *Planeb;
@property (weak, nonatomic) IBOutlet UIImageView *Birdb;
@property (weak, nonatomic) IBOutlet UIImageView *Smoke;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo1;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo2;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo3;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo4;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV03b

@synthesize defaults = _defaults;

- (void) birdAndPlaneMove
{
	self.SFX01.volume = 0.4;
	self.SFX02.volume = 0.6;
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Birdb.center = CGPointMake(1100, 120);
    } completion:nil];
    [UIView animateWithDuration:6.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Planeb.center = CGPointMake(1100, 162);
    } completion:nil];
}

- (void) smokeAndFlamingosAnimate
{
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat animations:^{
        self.Smoke.alpha = 0.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat animations:^{
        self.Flamingo1.center = CGPointMake(self.Flamingo1.center.x, self.Flamingo1.center.y + 10);
        self.Flamingo2.center = CGPointMake(self.Flamingo2.center.x, self.Flamingo2.center.y + 10);
        self.Flamingo3.center = CGPointMake(self.Flamingo3.center.x, self.Flamingo3.center.y + 10);
        self.Flamingo4.center = CGPointMake(self.Flamingo4.center.x, self.Flamingo4.center.y + 10);
    } completion:nil];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		[self.voiceOverPlayer stop];
		[self.SFX01 stop];
		[self.SFX02 stop];
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
		{
			[self.SFX01 play];
			[self.SFX02 play];
		}
	}
}

- (void) voiceoverPlayerFinishPlaying:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		self.btnBack.alpha = 1.0;
		self.btnNext.alpha = 1.0;
		self.btnBack.userInteractionEnabled = YES;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.defaults = [NSUserDefaults standardUserDefaults];
	
	[self.voiceOverPlayer setAudioFile:@"03b_VO.mp3"];
	[self.SFX01 setAudioFile:@"03_BG01.mp3"];
	[self.SFX02 setAudioFile:@"03_birdplane.mp3"];
	
	self.SFX01.volume = 0.4;
	self.SFX02.volume = 0.6;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
	
	self.Labelb.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
	
	[self birdAndPlaneMove];
	[self smokeAndFlamingosAnimate];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	self.Labelb = nil;
    self.Planeb = nil;
    self.Birdb = nil;
    self.Smoke = nil;
    self.Flamingo1 = nil;
    self.Flamingo2 = nil;
    self.Flamingo3 = nil;
    self.Flamingo4 = nil;
	
	self.btnBack = nil;
	self.btnNext = nil;
	
	self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
	
	self.defaults = nil;
}

@end
