//
//  SV03.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV03.h"

@interface SV03 ()

@property (weak, nonatomic) IBOutlet UIView *ViewAContainer;
@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIImageView *Bird;
@property (weak, nonatomic) IBOutlet UIImageView *Plane;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property NSUserDefaults *defaults;

@end

@implementation SV03

@synthesize defaults = _defaults;

- (void) birdAndPlaneMoving
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Bird.center = CGPointMake (1100, 167);
    } completion:nil];
    [UIView animateWithDuration:7 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Plane.center = CGPointMake (1100, 206);
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
    
    [self.voiceOverPlayer setAudioFile:@"03a_VO.mp3"];
	[self.SFX01 setAudioFile:@"03_BG01.mp3"];
	[self.SFX02 setAudioFile:@"03_birdplane.mp3"];
	
	self.SFX01.volume = 0.2;
	self.SFX02.volume = 1.0;
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    
    [self birdAndPlaneMoving];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setBG:nil];
    [self setLabel:nil];
    [self setBird:nil];
    [self setPlane:nil];
    
    self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
    
    self.defaults = nil;
}
- (void)viewDidUnload {
	[self setBtnNext:nil];
	[self setBtnBack:nil];
	[super viewDidUnload];
}
@end
