//
//  SV13.m
//  JennyJones
//
//  Created by Zune Moe on 25/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV13.h"

@interface SV13 ()

@property (strong, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *PedalFix;
@property (weak, nonatomic) IBOutlet UIImageView *PedalTurn;
@property (weak, nonatomic) IBOutlet UIImageView *Jenny;
@property (weak, nonatomic) IBOutlet UIImageView *Miao01;
@property (weak, nonatomic) IBOutlet UIImageView *Miao02;
@property (weak, nonatomic) IBOutlet UILabel *Label01;
@property (weak, nonatomic) IBOutlet UIImageView *Bike01;
@property (weak, nonatomic) IBOutlet UIImageView *Bike01L;
@property (weak, nonatomic) IBOutlet UIImageView *Bike01R;
@property (weak, nonatomic) IBOutlet UIImageView *Bike02;
@property (weak, nonatomic) IBOutlet UIImageView *Bike02L;
@property (weak, nonatomic) IBOutlet UIImageView *Bike02R;
@property (weak, nonatomic) IBOutlet UIImageView *Bike03;
@property (weak, nonatomic) IBOutlet UIImageView *Bike03L;
@property (weak, nonatomic) IBOutlet UIImageView *Bike03R;
@property (weak, nonatomic) IBOutlet UIImageView *Bike04;
@property (weak, nonatomic) IBOutlet UIImageView *Bike04L;
@property (weak, nonatomic) IBOutlet UIImageView *Bike04R;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV13

@synthesize defaults = _defaults;

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	CGPoint center = CGPointMake(CGRectGetMidX(self.PedalTurn.bounds), CGRectGetMidY(self.PedalTurn.bounds));
	
	if (touch.view == self.PedalTurn)
	{
		CGPoint currentPoint = [touch locationInView:self.PedalTurn];
		CGPoint previousPoint = [touch previousLocationInView:self.PedalTurn];
		
		CGFloat angleInRadians = atan2f(currentPoint.y - center.y, currentPoint.x - center.x) - atan2f(previousPoint.y - center.y, previousPoint.x - center.x);
		
		NSLog(@"Angle in radians: %g", angleInRadians);
		
		self.Miao01.hidden = YES;
		self.Miao02.hidden = NO;
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		
		//self.PedalTurn.transform = CGAffineTransformRotate(self.PedalTurn.transform, angleInRadians);
		self.PedalTurn.transform = CGAffineTransformRotate(self.PedalTurn.transform, atan2f(currentPoint.y - center.y, currentPoint.x - center.x));
		
		// Rotate
		self.Bike01L.transform = CGAffineTransformRotate(self.Bike01L.transform, angleInRadians);
		self.Bike01R.transform = CGAffineTransformRotate(self.Bike01R.transform, angleInRadians);
		
		self.Bike02L.transform = CGAffineTransformRotate(self.Bike02L.transform, angleInRadians);
		self.Bike02R.transform = CGAffineTransformRotate(self.Bike02R.transform, angleInRadians);
		
		self.Bike03L.transform = CGAffineTransformRotate(self.Bike03L.transform, angleInRadians);
		self.Bike03R.transform = CGAffineTransformRotate(self.Bike03R.transform, angleInRadians);
		
		self.Bike04L.transform = CGAffineTransformRotate(self.Bike04L.transform, angleInRadians);
		self.Bike04R.transform = CGAffineTransformRotate(self.Bike04R.transform, angleInRadians);
		
		// Bike01, L and R move
		self.Bike01.center = CGPointMake(self.Bike01.center.x + angleInRadians * 5, self.Bike01.center.y);
		self.Bike01L.center = CGPointMake(self.Bike01.center.x - 52, self.Bike01L.center.y);
		self.Bike01R.center = CGPointMake(self.Bike01.center.x + 69, self.Bike01R.center.y);
		
		// Bike02, L and R move
		self.Bike02.center = CGPointMake(self.Bike02.center.x + angleInRadians * 5, self.Bike02.center.y);
		self.Bike02L.center = CGPointMake(self.Bike02.center.x - 39, self.Bike02L.center.y);
		self.Bike02R.center = CGPointMake(self.Bike02.center.x + 39, self.Bike02R.center.y);
		
		// Bike03, L and R move
		self.Bike03.center = CGPointMake(self.Bike03.center.x + angleInRadians * 5, self.Bike03.center.y);
		self.Bike03L.center = CGPointMake(self.Bike03.center.x - 20, self.Bike03L.center.y);
		self.Bike03R.center = CGPointMake(self.Bike03.center.x + 32, self.Bike03R.center.y);
		
		// Bike04, L and R move
		self.Bike04.center = CGPointMake(self.Bike04.center.x + angleInRadians * 5, self.Bike04.center.y);
		self.Bike04L.center = CGPointMake(self.Bike04.center.x - 33, self.Bike04L.center.y);
		self.Bike04R.center = CGPointMake(self.Bike04.center.x + 34, self.Bike04R.center.y);

		if (self.Bike01.center.x > 1100) self.Bike01.center = CGPointMake(-80, self.Bike01.center.y);
		else if (self.Bike01.center.x < -80) self.Bike01.center = CGPointMake(1100, self.Bike01.center.y);
		
		if (self.Bike02.center.x > 1080) self.Bike02.center = CGPointMake(-50, self.Bike02.center.y);
		else if (self.Bike02.center.x < -50) self.Bike02.center = CGPointMake(1080, self.Bike02.center.y);
		
		if (self.Bike03.center.x > 1080) self.Bike03.center = CGPointMake(-50, self.Bike03.center.y);
		else if (self.Bike03.center.x < -50) self.Bike03.center = CGPointMake(1080, self.Bike03.center.y);
		
		if (self.Bike04.center.x > 1080) self.Bike04.center = CGPointMake(-50, self.Bike04.center.y);
		else if (self.Bike04.center.x < -50) self.Bike04.center = CGPointMake(1080, self.Bike04.center.y);
	}	
}

- (IBAction)bgTapped:(UITapGestureRecognizer *)sender
{
    self.Miao02.hidden = YES;
    self.Miao01.hidden = NO;
    [self.view bringSubviewToFront: self.Miao01];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
}

- (IBAction)jennyTapped:(UITapGestureRecognizer *)sender
{
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer stop];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX03 stop];
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX03 play];
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"13_VO.mp3"];
    [self.SFX01 setAudioFile:@"13_SFX01.mp3"];
    [self.SFX02 setAudioFile:@"13_SFX02.mp3"];
	[self.SFX03 setAudioFile:@"13_loop01.mp3"];
	[self.SFX04 setAudioFile:@"Miao01.mp3"];
	
	self.SFX03.repeats = YES;
    
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label01.font = [UIFont fontWithName:@"AFontwithSerifs" size:30];
    
    [NSTimer scheduledTimerWithTimeInterval:14 target:self selector:@selector(bgTapped:) userInfo:nil repeats:NO];
    
    self.PedalTurn.userInteractionEnabled = YES;
    self.PedalTurn.layer.anchorPoint = CGPointMake(0.5, 0.6);
    self.PedalTurn.center = CGPointMake(self.PedalTurn.center.x, self.PedalTurn.center.y + 23);
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.superView = nil;
    self.BG = nil;
    self.PedalFix = nil;
    self.PedalTurn = nil;
    self.Jenny = nil;
    self.Miao01 = nil;
    self.Miao02 = nil;
    self.Label01 = nil;
    
    self.Bike01 = nil;
    self.Bike01L = nil;
    self.Bike01R = nil;
    self.Bike02 = nil;
    self.Bike02L = nil;
    self.Bike02R = nil;
    self.Bike03 = nil;
    self.Bike03L = nil;
    self.Bike03R = nil;
    self.Bike04 = nil;
    self.Bike04L = nil;
    self.Bike04R = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
