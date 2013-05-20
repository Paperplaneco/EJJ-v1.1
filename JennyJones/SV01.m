//
//  SV01.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV01.h"

@interface SV01 ()

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Jenny;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV01

@synthesize defaults = _defaults;

- (IBAction)jennyTapped:(UITapGestureRecognizer *)sender
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.Jenny.frame = CGRectMake (122, 64, 317, 717);
    }completion:nil];
	self.Jenny.userInteractionEnabled = NO;
}

- (IBAction)littleJennyTapped:(UITapGestureRecognizer *)sender
{
    int random = rand() % (8 - 1 + 1) + 1;
    [self.SFX01 setAudioFile:[NSString stringWithFormat:@"01_Jenny0%d.mp3", random]];
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
}

- (IBAction)labelTapped:(UITapGestureRecognizer *)sender
{
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
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
		self.btnPrev.alpha = 1.0;
		self.btnNext.alpha = 1.0;
		self.btnPrev.userInteractionEnabled = YES;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	self.btnPrev.alpha = 0.25;
	self.btnNext.alpha = 0.25;
	
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"01_VO.mp3"];
	[self.SFX02 setAudioFile:@"01_Whoosh.mp3"];
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];

    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"MuteVoiceoverPlayer" object:nil];
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	
    [self setBtnPrev:nil];
	[self setBtnNext:nil];
	
    [self setBG:nil];
    [self setJenny:nil];
    [self setLabel:nil];
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
	self.SFX02 = nil;
    
    self.defaults = nil;
}

@end
