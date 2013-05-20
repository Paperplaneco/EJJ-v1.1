//
//  SV04.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV04.h"

@interface SV04 ()

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Round;
@property (weak, nonatomic) IBOutlet UIImageView *Square;
@property (weak, nonatomic) IBOutlet UIImageView *BugRound;
@property (weak, nonatomic) IBOutlet UIImageView *BugSquare;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV04

@synthesize defaults = _defaults;

- (IBAction)wordsTapped:(id)sender
{
    [UIView animateWithDuration:1.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.Round.alpha = 0.0;
        self.BugRound.alpha = 0.0;
        self.Square.alpha = 1.0;
        self.BugSquare.alpha = 1.0;
    }completion:nil];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer stop];
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
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
    
    [self.voiceOverPlayer setAudioFile:@"04_VO.mp3"];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Round.alpha = 1.0;
    self.BugRound.alpha = 1.0;
    self.Square.alpha = 0.0;
    self.BugSquare.alpha = 0.0;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setBG:nil];
    [self setRound:nil];
    [self setSquare:nil];
    [self setBugRound:nil];
    [self setBugSquare:nil];
    
    self.voiceOverPlayer = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnNext:nil];
	[self setBtnBack:nil];
	[super viewDidUnload];
}
@end
