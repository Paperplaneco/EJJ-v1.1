//
//  SV18.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 Paperplane Pilots Pte Ltd. All rights reserved.
//

#import "SV18.h"

@interface SV18 ()
{
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Outer;
@property (weak, nonatomic) IBOutlet UIImageView *OuterLights;
@property (weak, nonatomic) IBOutlet UIImageView *Inner;
@property (weak, nonatomic) IBOutlet UIImageView *InnerLights;

@property (weak, nonatomic) IBOutlet UIImageView *Carriage01;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage02;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage03;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage04;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage05;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage06;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage07;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage08;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage09;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage10;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage11;
@property (weak, nonatomic) IBOutlet UIImageView *Carriage12;

@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSTimer *timer;
@property NSUserDefaults *defaults;

@end

@implementation SV18

@synthesize timer;
@synthesize defaults = _defaults;

- (IBAction)outerWheelTapped:(UITapGestureRecognizer *)sender
{
    self.Outer.userInteractionEnabled = NO;
    
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotation.fromValue = [NSNumber numberWithFloat:0 * M_PI / 180];
    rotation.toValue = [NSNumber numberWithFloat:360 * M_PI / 180];
    rotation.duration = 6;
    rotation.repeatCount = HUGE_VALF;
    
    [self.Inner.layer addAnimation:rotation forKey:@"innerrotate"];
    [self.InnerLights.layer addAnimation:rotation forKey:@"innerrotate"];
    
    rotation.fromValue = [NSNumber numberWithFloat:-40 * M_PI / 180];
    rotation.toValue = [NSNumber numberWithFloat:40 * M_PI / 180];
    rotation.duration = 1;
    rotation.autoreverses = YES;
    rotation.repeatCount = HUGE_VALF;
    
    [self.Carriage01.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage02.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage03.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage04.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage05.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage06.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage07.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage08.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage09.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage10.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage11.layer addAnimation:rotation forKey:@"carriagerotate"];
    [self.Carriage12.layer addAnimation:rotation forKey:@"carriagerotate"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage01 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage02 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage03 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage04 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage05 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage06 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage07 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage08 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage09 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage10 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage11 repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(carriageMove:) userInfo:self.Carriage12 repeats:YES];
}

- (void) carriageMove: (NSTimer *) tmr
{
    UIImageView *carriageView = [tmr userInfo];
    
    int movingPoint = 1;
    
    if (carriageView.center.x <= 948 && carriageView.center.y == 59) carriageView.center = CGPointMake(carriageView.center.x + movingPoint, carriageView.center.y);
    
    if (carriageView.center.y <= 440 && carriageView.center.x == 948.5) carriageView.center = CGPointMake(carriageView.center.x, carriageView.center.y + movingPoint);
    
    if (carriageView.center.x >= 564 && carriageView.center.y == 440) carriageView.center = CGPointMake(carriageView.center.x - movingPoint, carriageView.center.y);
    
    if (carriageView.center.y >= 59 && carriageView.center.x == 564.5) carriageView.center = CGPointMake(carriageView.center.x, carriageView.center.y - movingPoint);
}

- (void) lightsTwinkle
{
    [UIView animateWithDuration:1.0 animations:^{
        if (self.InnerLights.alpha == 1.0) self.InnerLights.alpha = 0.2;
        else self.InnerLights.alpha = 1.0;
        
    }];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.OuterLights.alpha == 1.0) self.OuterLights.alpha = 0.2;
        else self.OuterLights.alpha = 1.0;
    }];
}

- (void) setInitPositionOfCarriage
{
    self.Carriage04.center = CGPointMake(948.5, self.Carriage04.center.y);
    self.Carriage05.center = CGPointMake(948.5, self.Carriage05.center.y);
    self.Carriage06.center = CGPointMake(948.5, self.Carriage06.center.y);
    
    self.Carriage10.center = CGPointMake(564.5, self.Carriage10.center.y);
    self.Carriage11.center = CGPointMake(564.5, self.Carriage11.center.y);
    self.Carriage12.center = CGPointMake(564.5, self.Carriage12.center.y);
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer stop];

		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX01 stop];
	}
	else
	{
		if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
			[self.voiceOverPlayer play];
			
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX01 play];
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
    
    [self.voiceOverPlayer setAudioFile:@"18_VO.mp3"];
    [self.SFX01 setAudioFile:@"18_SFX01.mp3"];
    
    self.SFX01.repeats = YES;
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:28];
    
    [self setInitPositionOfCarriage];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lightsTwinkle) userInfo:nil repeats:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.BG = nil;
    self.Inner = nil;
    self.InnerLights = nil;
    self.Outer = nil;
    self.OuterLights = nil;
    self.Carriage01 = nil;
    self.Carriage02 = nil;
    self.Carriage03 = nil;
    self.Carriage04 = nil;
    self.Carriage05 = nil;
    self.Carriage06 = nil;
    self.Carriage07 = nil;
    self.Carriage08 = nil;
    self.Carriage09 = nil;
    self.Carriage10 = nil;
    self.Carriage11 = nil;
    self.Carriage12 = nil;
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
