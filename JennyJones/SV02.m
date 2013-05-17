//
//  SV02.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV02.h"
#import "InfiniteScrollView.h"

@interface SV02 ()
{
    BOOL firstTimeScroll;
	int jonesPlayerCount;
	NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Miao;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet InfiniteScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;


@property NSUserDefaults *defaults;

@end

@implementation SV02

@synthesize defaults = _defaults;

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (firstTimeScroll == YES) {
        firstTimeScroll = NO;
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
		timer = [NSTimer scheduledTimerWithTimeInterval:0.45 target:self selector:@selector(playJones) userInfo:nil repeats:YES];
		
		[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
		
        self.Miao.image = [UIImage imageNamed:@"02_miao11.png"];
        
        self.Miao.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"02_miao01.png"],
                                     [UIImage imageNamed:@"02_miao02.png"],
                                     [UIImage imageNamed:@"02_miao03.png"],
                                     [UIImage imageNamed:@"02_miao04.png"],
                                     [UIImage imageNamed:@"02_miao05.png"],
                                     [UIImage imageNamed:@"02_miao06.png"],
                                     [UIImage imageNamed:@"02_miao07.png"],
                                     [UIImage imageNamed:@"02_miao08.png"],
                                     [UIImage imageNamed:@"02_miao09.png"],
                                     [UIImage imageNamed:@"02_miao10.png"],
                                     [UIImage imageNamed:@"02_miao11.png"],
                                     nil];
        
        self.Miao.animationDuration = 5;
        self.Miao.animationRepeatCount = 1;
        [self.Miao startAnimating];
		
		[[NSRunLoop mainRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:self.Miao.animationDuration - 0.55 target:self selector:@selector(miaoAnimate) userInfo:nil repeats:NO] forMode:NSRunLoopCommonModes];
    }
}

- (void) playJones
{
	jonesPlayerCount++;
	[self.SFX01 setAudioFile:[NSString stringWithFormat:@"02_Jones0%d.mp3", jonesPlayerCount]];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	
	if (jonesPlayerCount > 10) [timer invalidate];
}

- (void) miaoAnimate
{
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.revealPlayer play];
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
    
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;

	jonesPlayerCount = 1;
    firstTimeScroll = YES;
	
    [self.voiceOverPlayer setAudioFile:@"02_VO.mp3"];
    [self.revealPlayer setAudioFile:@"02_Miao11.mp3"];
    
    [self.SFX01 setAudioFile:@"02_Jones01.mp3"];
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:30];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setBG:nil];
    [self setMiao:nil];
    [self setLabel:nil];
    [self setScrollView:nil];
    
    self.voiceOverPlayer = nil;
    self.revealPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
    self.SFX04 = nil;
    self.SFX05 = nil;
    
    self.defaults = nil;
}
- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
