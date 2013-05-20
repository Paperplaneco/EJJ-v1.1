//
//  SV07.m
//  JennyJones
//
//  Created by Zune Moe on 18/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV07.h"

@interface SV07 ()
{
    CGPoint fish01Offset, fish02Offset, fish03Offset;
    BOOL fish01Transform, fish02Transform, fish03Transform;
}

@property (weak, nonatomic) IBOutlet UIImageView *EyeL;
@property (weak, nonatomic) IBOutlet UIImageView *EyeR;
@property (weak, nonatomic) IBOutlet UIImageView *Fish01;
@property (weak, nonatomic) IBOutlet UIImageView *Fish02;
@property (weak, nonatomic) IBOutlet UIImageView *Fish03;
@property (weak, nonatomic) IBOutlet UIImageView *Aqua;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV07

@synthesize defaults = _defaults;

- (void) playBubbleSound
{
	int random = rand() % (6 - 1 + 1) + 1;
	[self.SFX01 setAudioFile:[NSString stringWithFormat:@"07_bubble0%d.mp3", random]];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
}

- (IBAction)fish01Tapped:(UITapGestureRecognizer *)sender
{
    [self playBubbleSound];
    
    UIImageView *bubble = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"07_Bubble.png"]];
    float x;
    float y = self.Fish01.center.y + 10;
    if (!fish01Transform)
    {
        x = self.Fish01.center.x - 80;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    } else {
        x = self.Fish01.center.x + 80;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    }
}

- (IBAction)fish02Tapped:(UITapGestureRecognizer *)sender
{
    [self playBubbleSound];
    
    UIImageView *bubble = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"07_Bubble.png"]];
    float x; 
    float y = self.Fish02.center.y - 25; 
    if (!fish02Transform)
    {
        x = self.Fish02.center.x + 90;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    } else {
        x = self.Fish02.center.x - 90;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    }
}

- (IBAction)fish03Tapped:(UITapGestureRecognizer *)sender
{
    [self playBubbleSound];
    
    UIImageView *bubble = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"07_Bubble.png"]];
    float x;
    float y = self.Fish03.center.y - 25;
    if (!fish03Transform)
    {
        x = self.Fish03.center.x - 55;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    } else {
        x = self.Fish03.center.x + 55;
        bubble.center = CGPointMake(x, y);
        [self.view addSubview:bubble];
        
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            bubble.center = CGPointMake(x, 280);
        } completion:^(BOOL finished) {
            [bubble removeFromSuperview];
        }];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.Aqua];
    
    if (touchLocation.x < 230) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.EyeL.center = CGPointMake(202, 350);
            self.EyeR.center = CGPointMake(406, 358);
        } completion:nil];
    }
    else if (touchLocation.x > 480) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.EyeL.center = CGPointMake(215, 354);
            self.EyeR.center = CGPointMake(426, 353);
        } completion:nil];
    }
    else if (230 < touchLocation.x < 480) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.EyeL.center = CGPointMake(208, 351);
            self.EyeR.center = CGPointMake(418, 356);
        } completion:nil];
    }
    
}

- (void) fish01Move
{    
    self.Fish01.center = CGPointMake(self.Fish01.center.x + fish01Offset.x, self.Fish01.center.y + fish01Offset.y);
    
    // Hit Left
    if (self.Fish01.center.x - self.Fish01.frame.size.width / 2 <  350 && fish01Offset.x < 0)
    {
        self.Fish01.transform = CGAffineTransformMakeScale(-1, 1);
        fish01Transform = YES;
        fish01Offset.x = -fish01Offset.x;
    }
    
    // Hit Right
    if (self.Fish01.center.x + self.Fish01.frame.size.width / 2 > self.view.frame.size.width && fish01Offset.x > 0)
    {
        self.Fish01.transform = CGAffineTransformMakeScale(1, 1);
        fish01Transform = NO;
        fish01Offset.x = -fish01Offset.x;
    }
    
    // Hit Top and Bottom
    if ((self.Fish01.center.y - self.Fish01.frame.size.height / 2 < 280 && fish01Offset.y < 0) || (self.Fish01.center.y + self.Fish01.frame.size.height / 2 > self.view.frame.size.height && fish01Offset.y > 0))
    {
        fish01Offset.y = -fish01Offset.y;
    }
}

- (void) fish02Move
{
    self.Fish02.center = CGPointMake(self.Fish02.center.x + fish02Offset.x, self.Fish02.center.y + fish02Offset.y);
    
    // Hit Left
    if (self.Fish02.center.x - self.Fish02.frame.size.width / 2 <  350 && fish02Offset.x < 0)
    {
        self.Fish02.transform = CGAffineTransformMakeScale(1, 1);
        fish02Transform = NO;
        fish02Offset.x = -fish02Offset.x;
    }
    
    // Hit Right
    if (self.Fish02.center.x + self.Fish02.frame.size.width / 2 > self.view.frame.size.width && fish02Offset.x > 0)
    {
        self.Fish02.transform = CGAffineTransformMakeScale(-1, 1);
        fish02Transform = YES;
        fish02Offset.x = -fish02Offset.x;
    }
    
    // Hit Top and Bottom
    if ((self.Fish02.center.y - self.Fish02.frame.size.height / 2 < 280 && fish02Offset.y < 0) || (self.Fish02.center.y + self.Fish02.frame.size.height / 2 > self.view.frame.size.height && fish02Offset.y > 0))
    {
        fish02Offset.y = -fish02Offset.y;
    }
}

- (void) fish03Move
{
    self.Fish03.center = CGPointMake(self.Fish03.center.x + fish03Offset.x, self.Fish03.center.y + fish03Offset.y);
    
    // Hit Left
    if (self.Fish03.center.x - self.Fish03.frame.size.width / 2 <  350 && fish03Offset.x < 0)
    {
        self.Fish03.transform = CGAffineTransformMakeScale(-1, 1);
        fish03Transform = YES;
        fish03Offset.x = -fish03Offset.x;
    }
    
    // Hit Right
    if (self.Fish03.center.x + self.Fish03.frame.size.width / 2 > self.view.frame.size.width && fish03Offset.x > 0)
    {
        self.Fish03.transform = CGAffineTransformMakeScale(1, 1);
        fish03Transform = NO;
        fish03Offset.x = -fish03Offset.x;
    }
    
    // Hit Top and Bottom
    if ((self.Fish03.center.y - self.Fish03.frame.size.height / 2 < 280 && fish03Offset.y < 0) || (self.Fish03.center.y + self.Fish03.frame.size.height / 2 > self.view.frame.size.height && fish03Offset.y > 0))
    {
        fish03Offset.y = -fish03Offset.y;
    }
}

- (void) fishMovingTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(fish01Move) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(fish02Move) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(fish03Move) userInfo:nil repeats:YES];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer stop];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX02 stop];
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX02 play];
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
    
    [self.voiceOverPlayer setAudioFile:@"07_VO.mp3"];
	[self.SFX02 setAudioFile:@"07_fishtank.mp3"];
	
	self.SFX02.repeats = YES;
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:29];
    
    fish01Offset = CGPointMake(5, 5);
    fish02Offset = CGPointMake(7, 6);
    fish03Offset = CGPointMake(6, 3.5);
    
    fish01Transform = NO;
    fish02Transform = NO;
    fish03Transform = NO;
    
    [self fishMovingTimer];
	
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
    
    self.EyeL = nil;
    self.EyeR = nil;
    self.Fish01 = nil;
    self.Fish02 = nil;
    self.Fish03 = nil;
    self.Aqua = nil;
    self.Label = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
