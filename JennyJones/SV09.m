//
//  SV09.m
//  JennyJones
//
//  Created by Zune Moe on 21/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV09.h"
#import <QuartzCore/QuartzCore.h>

#define P(x,y) CGPointMake(x, y)
#define FruitCount 3

@interface SV09 ()
{
    UIImageView *fruit[FruitCount];
    int fruit0TouchCount, fruit1TouchCount, fruit2TouchCount;
    BOOL eatAllFruits;
    float rMovingAmount;
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *Jenny01;
@property (weak, nonatomic) IBOutlet UIImageView *Jenny02;
@property (weak, nonatomic) IBOutlet UIImageView *Oops;
@property (weak, nonatomic) IBOutlet UIImageView *Dessert;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV09

@synthesize defaults = _defaults;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if ([fruit[0].layer.presentationLayer hitTest:touchLocation] && fruit0TouchCount < 4) {
        fruit0TouchCount++;
        fruit[0].image = [UIImage imageNamed:[NSString stringWithFormat:@"09_Peas0%d.png", fruit0TouchCount]];
        [self fruitBiteSoundPlay];
    }
    if ([fruit[1].layer.presentationLayer hitTest:touchLocation] && fruit1TouchCount < 4) {
        fruit1TouchCount++;
        fruit[1].image = [UIImage imageNamed:[NSString stringWithFormat:@"09_Corn0%d.png", fruit1TouchCount]];
        [self fruitBiteSoundPlay];
    }
    if ([fruit[2].layer.presentationLayer hitTest:touchLocation] && fruit2TouchCount < 4) {
        fruit2TouchCount++;
        fruit[2].image = [UIImage imageNamed:[NSString stringWithFormat:@"09_Tomato0%d.png", fruit2TouchCount]];
        [self fruitBiteSoundPlay];
    }
}

- (void) fruitBiteSoundPlay
{
	int random = rand() % (3 - 1 + 1) + 1;
	[self.SFX01 setAudioFile:[NSString stringWithFormat:@"09_bite0%d.mp3", random]];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
}

- (void) resetFruitPosition
{
    float fruitY;
    float fruitWidth, fruitHeight;
    float fruitBetweenWidth;
    float fruitStartX;
    
    fruitWidth = 240;
    fruitHeight = 108;
    fruitBetweenWidth = 300;
    
    fruitY = 678;
    fruitStartX = 1030;
    
    for (int fruitIndex = 0; fruitIndex < FruitCount; fruitIndex++) {
        fruit[fruitIndex].frame = CGRectMake(fruitStartX + fruitBetweenWidth * fruitIndex, fruitY - fruitHeight, fruitWidth, fruitHeight);
        
        UIImage *image = nil;
        
        switch (fruitIndex) {
            case 0:
                image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"09_Peas01" ofType:@"png"]];
                break;
            case 1:
                image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"09_Corn01" ofType:@"png"]];
                break;
            case 2:
                image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"09_Tomato01" ofType:@"png"]];
                break;
            default:
                break;
        }
        
        fruit[fruitIndex].image = image;
    }
    
    // Reset fruit touch count
    fruit0TouchCount = 1;
    fruit1TouchCount = 1;
    fruit2TouchCount = 1;
}

- (void) fruitMoving
{
    for (int fruitIndex = 0; fruitIndex < FruitCount; fruitIndex++) {
        CGRect frame = fruit[fruitIndex].frame;
        
        fruit[fruitIndex].frame = CGRectMake(frame.origin.x - rMovingAmount, frame.origin.y, 240, 108);
    }
    
    if (fruit0TouchCount > 3 && fruit1TouchCount > 3 && fruit2TouchCount > 3)
    {
        eatAllFruits = YES;
        
        fruit0TouchCount = 1;
        fruit1TouchCount = 1;
        fruit2TouchCount = 1;
        
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.revealPlayer play];
        
        rMovingAmount = 15;
        //self.Jenny01.hidden = YES;
        //self.Jenny02.hidden = NO;
        self.Oops.hidden = YES;
        
        [self animateDessert];
    }
    
    if (fruit[2].frame.origin.x < - fruit[2].frame.size.width && eatAllFruits == NO)
    {
        self.Oops.hidden = NO;
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
        [self resetFruitPosition];
    }
}

- (void) animateDessert
{
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.Dessert.center = CGPointMake(400, self.Dessert.center.y);
    } completion:^(BOOL finished) {
        [timer invalidate];
        [UIView animateWithDuration:0.5 animations:^{
            self.Dessert.center = CGPointMake(516, self.Dessert.center.y);
        }];
    }];
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
    
    [self.voiceOverPlayer setAudioFile:@"09_VO.mp3"];
    [self.revealPlayer setAudioFile:@"09_desert01.mp3"];
    [self.SFX02 setAudioFile:@"Miao01.mp3"];
	[self.SFX03 setAudioFile:@"09_loop.mp3"];
	
	self.SFX03.repeats = YES;
	
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:30];
    
    fruit0TouchCount = 1;
    fruit1TouchCount = 1;
    fruit2TouchCount = 1;
    
    rMovingAmount = 2;
    
    self.Dessert.hidden = NO;
    self.Dessert.center = CGPointMake(1500, self.Dessert.center.y);
    
    for (int fruitIndex = 0; fruitIndex < FruitCount; fruitIndex++) {
        fruit[fruitIndex] = [[UIImageView alloc] init];
        [self.view addSubview: fruit[fruitIndex]];
    }
    
    [self resetFruitPosition];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fruitMoving) userInfo:nil repeats:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.Jenny01 = nil;
    self.Jenny02 = nil;
    self.Dessert = nil;
    self.Label = nil;
    self.Oops = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.revealPlayer = nil;
    
    self.defaults = nil;
    
    for (int fruitIndex = 0; fruitIndex < FruitCount; fruitIndex++) {
        [fruit[fruitIndex] removeFromSuperview];
    }
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
