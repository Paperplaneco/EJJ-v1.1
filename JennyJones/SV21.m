//
//  SV21.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV21.h"
#import <QuartzCore/CoreAnimation.h>

@interface SV21 ()
{
    float scale;
    NSTimer *basketTimer;
    
    CAEmitterLayer *fireworksEmitter;
    CAEmitterCell *rocket;
    CAEmitterCell *burst;
    CAEmitterCell *spark;
}

@property (weak, nonatomic) IBOutlet UIImageView *Basket;
@property (weak, nonatomic) IBOutlet UIImageView *TentLights01;
@property (weak, nonatomic) IBOutlet UIImageView *TentLights02;
@property (weak, nonatomic) IBOutlet UIImageView *FerrisLights;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (nonatomic) NSTimer *basketTimer;
@property (nonatomic) NSTimer *creditRollTimer;
@property NSUserDefaults *defaults;

@end

@implementation SV21

@synthesize basketTimer, creditRollTimer;
@synthesize defaults = _defaults;

- (void) lightsTwinkling: (NSTimer *) tmr
{
    UIImageView *imageView = [tmr userInfo];
    
    [UIView animateWithDuration:0.5 animations:^{
        if (imageView.alpha == 1.0) imageView.alpha = 0.0;
        else imageView.alpha = 1.0;
    }];
}

- (void) basketMoving
{
    scale -= 0.0005;
    if (scale < 0.4) [self.basketTimer invalidate];
    self.Basket.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void) startTimer
{
    //self.Label.hidden = YES;
    
    //self.basketTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(basketMoving) userInfo:nil repeats:YES];
    //self.creditRollTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(creditRollStartRolling) userInfo:nil repeats:YES];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    
    int random = rand() % (4 - 1 + 1) + 1;
    [self.SFX01 setAudioFile:[NSString stringWithFormat:@"21_FW0%d.mp3", random]];
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    
    [self touchAtPosition:currentPoint];
}

- (void) touchAtPosition:(CGPoint)position
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.rocket.birthRate"];
    anim.fromValue = [NSNumber numberWithFloat:2.0];
    anim.toValue = [NSNumber numberWithFloat:0.0];
    anim.duration = 1.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [fireworksEmitter addAnimation:anim forKey:@"burst"];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    fireworksEmitter.emitterPosition = position;
    [CATransaction commit];
}

- (void) setupFireWork
{
    fireworksEmitter = [CAEmitterLayer layer];
    
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width / 2.0, viewBounds.size.height / 2.0);
    fireworksEmitter.emitterSize = CGSizeMake(100, 0.0);
    fireworksEmitter.emitterMode = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape = kCAEmitterLayerLine;
    fireworksEmitter.renderMode = kCAEmitterLayerAdditive;
    fireworksEmitter.seed = (arc4random() % 100) + 1;
    
    // Create the rocket
	rocket = [CAEmitterCell emitterCell];
	rocket.name = @"rocket";
	rocket.birthRate		= 0.0;
	rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
	rocket.velocity			= 220;
	rocket.velocityRange	= 180;
	rocket.yAcceleration	= 75;
	rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
	
	rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
	rocket.scale			= 0.2;
	rocket.color			= [[UIColor redColor] CGColor];
	rocket.greenRange		= 1.0;		// different colors
	rocket.redRange			= 1.0;
	rocket.blueRange		= 1.0;
	rocket.spinRange		= M_PI;		// slow spin
    
    burst = [CAEmitterCell emitterCell];
    burst.name = @"burst";
    burst.birthRate = 1.0;
    burst.velocity = 1;
    burst.scale = 2.5;
    burst.redSpeed = -1.5;
    burst.blueSpeed = +1.5;
    burst.greenSpeed = +1.0;
    burst.lifetime = 0.35;
    
    spark = [CAEmitterCell emitterCell];
    spark.name = @"spark";
    spark.birthRate = 400;
    spark.velocity = 125;
    spark.emissionRange = 2 * M_PI; // 360 degree
    spark.yAcceleration = 75; // gravity
    spark.lifetime = 3;
    
    spark.contents = (id) [[UIImage imageNamed:@"emitter"] CGImage];
    spark.scale = 1.2;
    spark.scaleSpeed = -0.2;
    
    //    spark.greenRange = +0.8;
    //    spark.redRange = -0.1;
    //    spark.blueRange = -0.5;
    
    spark.greenSpeed = -0.1;
    spark.redSpeed = 0.4;
    spark.blueSpeed = -0.1;
    spark.alphaSpeed = -0.25;
    spark.spin = 2 * M_PI;
    spark.spinRange = 2 * M_PI;
    
    fireworksEmitter.emitterCells = [NSArray arrayWithObject:rocket];
    rocket.emitterCells = [NSArray arrayWithObject:burst];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
}

- (void) lightsStartTwinkling
{
    // Lights twinkling
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(lightsTwinkling:) userInfo:self.TentLights01 repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(lightsTwinkling:) userInfo:self.TentLights02 repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(lightsTwinkling:) userInfo:self.FerrisLights repeats:YES];
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
    
    [self.voiceOverPlayer setAudioFile:@"21_VO.mp3"];
    
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:30];
    
    scale = 1.0;
    
    self.Basket.layer.anchorPoint = CGPointMake(0, 0);
    self.Basket.frame = CGRectMake(0, 0, self.Basket.frame.size.width, self.Basket.frame.size.height);
    
    [self lightsStartTwinkling];
    
    // CreditImage start rolling
    //[NSTimer scheduledTimerWithTimeInterval:31.0 target:self selector:@selector(startTimer) userInfo:nil repeats:NO];
    
    // Setup firework
    [self setupFireWork];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.Basket = nil;
    self.TentLights01 = nil;
    self.TentLights02 = nil;
    self.FerrisLights = nil;
    self.Label = nil;
    
    [self.basketTimer invalidate];
    [self.creditRollTimer invalidate];
    
    self.basketTimer = nil;
    self.creditRollTimer = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
	self.SFX07 = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
