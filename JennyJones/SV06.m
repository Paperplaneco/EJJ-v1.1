//
//  SV06.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SV06.h"

#define fCount 8

#define FRUIT01_POS CGPointMake(434,554)
#define FRUIT02_POS CGPointMake(630,562)
#define FRUIT03_POS CGPointMake(340,514)
#define FRUIT03_01_POS CGPointMake(570,562)
#define FRUIT04_POS CGPointMake(564,524)
#define FRUIT05_POS CGPointMake(466,547)
#define FRUIT06_POS CGPointMake(402,510)
#define FRUIT07_POS CGPointMake(656,525)
#define BOWL_POS CGPointMake(584,614)

@interface SV06 ()
{
    NSTimer *timer;
    int frameCount;
    UIImageView *imageView[8];
    BOOL fruitCollision[8];
	BOOL moveFruitWithBowl[8];
	NSTimer *fruitFallTimer[8];
    
    float valueX;
    float valueY;
    CGPoint bowlVelocity;
    int fruitCollectionCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit01;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit02;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit03;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit03_01;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit04;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit05;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit06;
@property (weak, nonatomic) IBOutlet UIImageView *Fruit07;
@property (weak, nonatomic) IBOutlet UIImageView *Bowl;
@property (weak, nonatomic) IBOutlet UIImageView *Instructions;
@property (weak, nonatomic) IBOutlet UIImageView *WinMessage;
@property (weak, nonatomic) IBOutlet UIImageView *TryAgainMessage;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV06

@synthesize defaults = _defaults;

- (void) collisionDetection
{
    CGRect bowl = CGRectMake(self.Bowl.frame.origin.x - 70, self.Bowl.frame.origin.y, 550, 40);
    
	if (CGRectIntersectsRect(bowl, self.Fruit01.frame) && fruitCollision[0])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[0] = NO;
		moveFruitWithBowl[0] = YES;
		[fruitFallTimer[0] invalidate];
	}
	
	if (CGRectIntersectsRect(bowl, self.Fruit02.frame) && fruitCollision[1])
	{
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		//fruitCollectionCount++;
		fruitCollision[1] = NO;
		moveFruitWithBowl[1] = YES;
		[fruitFallTimer[1] invalidate];
	}
    
	if (CGRectIntersectsRect(bowl, self.Fruit03.frame) && fruitCollision[2])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[2] = NO;
		moveFruitWithBowl[2] = YES;
		[fruitFallTimer[2] invalidate];
	}
    
	if (CGRectIntersectsRect(bowl, self.Fruit03_01.frame) && fruitCollision[3])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[3] = NO;
		moveFruitWithBowl[3] = YES;
		[fruitFallTimer[3] invalidate];
	}
    
	if (CGRectIntersectsRect(bowl, self.Fruit04.frame) && fruitCollision[4])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[4] = NO;
		moveFruitWithBowl[4] = YES;
		[fruitFallTimer[4] invalidate];
	}
    
	if (CGRectIntersectsRect(bowl, self.Fruit05.frame) && fruitCollision[5])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[5] = NO;
		moveFruitWithBowl[5] = YES;
		[fruitFallTimer[5] invalidate];
	}

	if (CGRectIntersectsRect(bowl, self.Fruit06.frame) && fruitCollision[6])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		fruitCollision[6] = NO;
		moveFruitWithBowl[6] = YES;
		[fruitFallTimer[6] invalidate];
	}
	
	if (CGRectIntersectsRect(bowl, self.Fruit07.frame) && fruitCollision[7])
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		self.Instructions.hidden = YES;
		fruitCollision[7] = NO;
		moveFruitWithBowl[7] = YES;
		[fruitFallTimer[7] invalidate];
	}
}

- (void) moveFruitWithBowl
{
	if (moveFruitWithBowl[0]) self.Fruit01.center = CGPointMake(self.Bowl.center.x - 150, 570);
	if (moveFruitWithBowl[1]) self.Fruit02.center = CGPointMake(self.Bowl.center.x + 45, 570);
	if (moveFruitWithBowl[2]) self.Fruit03.center = CGPointMake(self.Bowl.center.x - 244, 550);
	if (moveFruitWithBowl[3]) self.Fruit03_01.center = CGPointMake(self.Bowl.center.x -14, 550);
	if (moveFruitWithBowl[4]) self.Fruit04.center = CGPointMake(self.Bowl.center.x -20, 555);
	if (moveFruitWithBowl[5]) self.Fruit05.center = CGPointMake(self.Bowl.center.x - 119, 560);
	if (moveFruitWithBowl[6]) self.Fruit06.center = CGPointMake(self.Bowl.center.x - 182, 570);
	if (moveFruitWithBowl[7]) self.Fruit07.center = CGPointMake(self.Bowl.center.x + 71, 570);
}

- (void) startTimer
{
    frameCount = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loopCallForFruitFall) userInfo:nil repeats:YES];
}

- (void) loopCallForFruitFall
{
    fruitFallTimer[frameCount] = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(fruitFalling:) userInfo:imageView[frameCount] repeats:YES];
    frameCount ++;
    
    if (frameCount > 8)
    {
        [timer invalidate];
		[fruitFallTimer[frameCount-1] invalidate];
		[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
		self.WinMessage.hidden = NO;
		[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resetObjects) userInfo:nil repeats:NO];
    }
}

- (void) fruitFalling: (NSTimer *) tmr
{
    UIImageView *imgView = [tmr userInfo];
    
    float fallingPoint = 13.5;
    
    if (imgView.center.y < 550)
        imgView.center = CGPointMake(imgView.center.x, imgView.center.y + fallingPoint);
	else
	{
		[timer invalidate];
		[fruitFallTimer[frameCount-1] invalidate];
		[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
		self.TryAgainMessage.hidden = NO;
		[self.SFX03 play];
		[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resetObjects) userInfo:nil repeats:NO];
	}
}

- (IBAction)bowlTapped:(UITapGestureRecognizer *)sender
{
    self.Bowl.userInteractionEnabled = NO;
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/60.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];

    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    [UIView animateWithDuration:2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.Fruit01.center = CGPointMake(850, 140);
        self.Fruit02.center = CGPointMake(512, 330);
        self.Fruit03.center = CGPointMake(300, 120);
        self.Fruit03_01.center = CGPointMake(630, 100);
        self.Fruit04.center = CGPointMake(900, 350);
        self.Fruit05.center = CGPointMake(100, 300);
        self.Fruit06.center = CGPointMake(100, 80);
        self.Fruit07.center = CGPointMake(700, 330);
    }completion:^(BOOL finished) {
        [self startTimer];
		self.Instructions.hidden = YES;
    }];
}

- (IBAction)miaoTapped:(UITapGestureRecognizer *)sender
{
	self.Instructions.hidden = NO;
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideMiao) userInfo:nil repeats:NO];
}

- (void) hideMiao
{
	self.Instructions.hidden = YES;
}

- (void) resetObjects
{
	self.Bowl.center = BOWL_POS;
	self.Fruit01.center = FRUIT01_POS;
	self.Fruit02.center = FRUIT02_POS;
	self.Fruit03.center = FRUIT03_POS;
	self.Fruit03_01.center = FRUIT03_01_POS;
	self.Fruit04.center = FRUIT04_POS;
	self.Fruit05.center = FRUIT05_POS;
	self.Fruit06.center = FRUIT06_POS;
	self.Fruit07.center = FRUIT07_POS;
	
	fruitCollision[0] = YES;
    fruitCollision[1] = YES;
    fruitCollision[2] = YES;
    fruitCollision[3] = YES;
    fruitCollision[4] = YES;
    fruitCollision[5] = YES;
    fruitCollision[6] = YES;
    fruitCollision[7] = YES;
	
	moveFruitWithBowl[0] = NO;
	moveFruitWithBowl[1] = NO;
	moveFruitWithBowl[2] = NO;
	moveFruitWithBowl[3] = NO;
	moveFruitWithBowl[4] = NO;
	moveFruitWithBowl[5] = NO;
	moveFruitWithBowl[6] = NO;
	moveFruitWithBowl[7] = NO;
	
	self.Instructions.hidden = YES;
	self.WinMessage.hidden = YES;
	self.TryAgainMessage.hidden = YES;
	
	self.Bowl.userInteractionEnabled = YES;
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float deceleration = 0.8f;
    float sensitivity = 12.0f;
    float maximumVelocity = 100;
    
    // adjust velocity based on current accelerometer acceleration
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        bowlVelocity.y = bowlVelocity.y * deceleration + acceleration.y * sensitivity;
    }
    else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        bowlVelocity.y = (bowlVelocity.y) * deceleration + (-acceleration.y) * sensitivity;
    }
    
    //limit the maximum velocity of the bowl, in both directions (positive & negative values)
    bowlVelocity.y = fmax(fminf(bowlVelocity.y, maximumVelocity), -maximumVelocity);
    
    self.Bowl.center = CGPointMake(self.Bowl.center.x + bowlVelocity.y, self.Bowl.center.y);
    
    // Left
    if (self.Bowl.center.x < 355) self.Bowl.center = CGPointMake(355, self.Bowl.center.y);
    
    // Right
    if (self.Bowl.center.x > 830) self.Bowl.center = CGPointMake(830, self.Bowl.center.y);
    
    [self collisionDetection];
	[self moveFruitWithBowl];
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
		self.btnNext.alpha = 1.0;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"06_VO.mp3"];
    [self.SFX01 setAudioFile:@"06_SFX01.mp3"];
    [self.SFX02 setAudioFile:@"06_SFX02.mp3"];
	[self.SFX03 setAudioFile:@"09_Miao01.mp3"];
    [self.revealPlayer setAudioFile:@"MrMiaow.mp3"];
    
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"] &&
		[[self.defaults objectForKey:@"play voiceover"] isEqualToString:@"YES"])
		[self.voiceOverPlayer play];
	
	[self.defaults setObject:@"YES" forKey:@"play voiceover"];
	[self.defaults synchronize];
	
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:23];
	
    imageView[0] = self.Fruit01;
    imageView[1] = self.Fruit02;
    imageView[2] = self.Fruit03;
    imageView[3] = self.Fruit03_01;
    imageView[4] = self.Fruit04;
    imageView[5] = self.Fruit05;
    imageView[6] = self.Fruit06;
    imageView[7] = self.Fruit07;
	
	[self resetObjects];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setBG:nil];
    [self setFruit01:nil];
    [self setFruit02:nil];
    [self setFruit03:nil];
    [self setFruit03_01:nil];
    [self setFruit04:nil];
    [self setFruit05:nil];
    [self setFruit06:nil];
    [self setFruit07:nil];
    [self setBowl:nil];
    [self setInstructions:nil];
	[self setWinMessage:nil];
	[self setTryAgainMessage:nil];
    [self setLabel:nil];
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
	self.SFX03 = nil;
    self.revealPlayer = nil;
    
	[timer invalidate];
	
	timer = nil;
	
	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
	
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
