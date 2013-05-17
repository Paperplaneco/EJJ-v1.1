//
//  SV19.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV19.h"

#define LEFT_SIDE_OF_VIEW 200
#define RIGHT_SIDE_OF_VIEW 900
#define LEFT_SIDE_OF_TRUNK 350
#define RIGHT_SIDE_OF_TRUNK 700

#define ANIMAL_MIN_BOUNCE_POINT 200
#define ANIMAL_MAX_BOUNCE_POINT 320

@interface SV19 ()
{
    BOOL animalRetrievedBoolValue[6];
    BOOL animalIsInForeground[6];
    BOOL animalBounceUp[6];
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Trunk;
@property (weak, nonatomic) IBOutlet UIImageView *StartAnimating;
@property (weak, nonatomic) IBOutlet UILabel *Label;

@property (weak, nonatomic) IBOutlet UIView *FrogView;
@property (weak, nonatomic) IBOutlet UIImageView *FrogViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Frog;

@property (weak, nonatomic) IBOutlet UIView *DolphinView;
@property (weak, nonatomic) IBOutlet UIImageView *DolphinViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Dolphin;

@property (weak, nonatomic) IBOutlet UIView *CatView;
@property (weak, nonatomic) IBOutlet UIImageView *CatViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Cat;

@property (weak, nonatomic) IBOutlet UIView *DragonView;
@property (weak, nonatomic) IBOutlet UIImageView *DragonViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Dragon;

@property (weak, nonatomic) IBOutlet UIView *RabbitView;
@property (weak, nonatomic) IBOutlet UIImageView *RabbitViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Rabbit;

@property (weak, nonatomic) IBOutlet UIView *MushroomView;
@property (weak, nonatomic) IBOutlet UIImageView *MushroomViewPole;
@property (weak, nonatomic) IBOutlet UIImageView *Mushroom;

@property (weak, nonatomic) IBOutlet UIImageView *TopRoof;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV19

@synthesize defaults = _defaults;

- (IBAction)startAnimating:(UITapGestureRecognizer *)sender
{
	self.StartAnimating.userInteractionEnabled = NO;
	
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
	{
		[self.SFX01 play];
		[self.SFX02 play];
	}
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.FrogView, @"imageView", self.Frog, @"animal", [NSNumber numberWithBool:YES], @"foreground", [NSNumber numberWithInt:0], @"boolIndex", nil] repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.DolphinView, @"imageView", self.Dolphin, @"animal", [NSNumber numberWithBool:YES], @"foreground", [NSNumber numberWithInt:1], @"boolIndex", nil] repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.CatView, @"imageView", self.Cat, @"animal", [NSNumber numberWithBool:NO], @"foreground", [NSNumber numberWithInt:2], @"boolIndex", nil] repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.DragonView, @"imageView", self.Dragon, @"animal", [NSNumber numberWithBool:NO], @"foreground", [NSNumber numberWithInt:3], @"boolIndex", nil] repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.RabbitView, @"imageView", self.Rabbit, @"animal", [NSNumber numberWithBool:NO], @"foreground", [NSNumber numberWithInt:4], @"boolIndex", nil] repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(marryGoRoundSpinning:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.MushroomView, @"imageView", self.Mushroom, @"animal", [NSNumber numberWithBool:YES], @"foreground", [NSNumber numberWithInt:5], @"boolIndex", nil] repeats:YES];
}

- (void) marryGoRoundSpinning: (NSTimer *) tmr
{
    int xMovingAmount = 1;
    int yMovingAmount = 1;
    
    int boolIndex = [[[tmr userInfo] objectForKey:@"boolIndex"] intValue];
    
    UIImageView *imageView = [[tmr userInfo] objectForKey:@"imageView"];
    UIImageView *animal = [[tmr userInfo] objectForKey:@"animal"];
    
    if (!animalRetrievedBoolValue[boolIndex])
    {
        animalIsInForeground[boolIndex] = [[[tmr userInfo] objectForKey:@"foreground"] boolValue];
        animalRetrievedBoolValue[boolIndex]= YES;
    }
    
    // Image in foreground
    if (animalIsInForeground[boolIndex] && imageView.center.x > LEFT_SIDE_OF_VIEW) imageView.center = CGPointMake(imageView.center.x - xMovingAmount, imageView.center.y);
    else
    {
        animalIsInForeground[boolIndex] = NO;
        imageView.transform = CGAffineTransformMakeScale(-0.6, 0.6);
    }
    
    // Image in background
    if (!animalIsInForeground[boolIndex] && imageView.center.x < RIGHT_SIDE_OF_VIEW) imageView.center = CGPointMake(imageView.center.x + xMovingAmount, imageView.center.y);
    else
    {
        animalIsInForeground[boolIndex] = YES;
        imageView.transform = CGAffineTransformMakeScale(1, 1);
        [self.view bringSubviewToFront:imageView];
		[self.view bringSubviewToFront:self.TopRoof];
    }
    
    // Image behind trunk
    if (!animalIsInForeground[boolIndex] && imageView.center.x > LEFT_SIDE_OF_TRUNK && imageView.center.x < RIGHT_SIDE_OF_TRUNK)
        imageView.alpha = 0;
    else imageView.alpha = 1;
    
    // Animal bounce up and down
    if (animalBounceUp[boolIndex] && animal.center.y > ANIMAL_MIN_BOUNCE_POINT) animal.center = CGPointMake(animal.center.x, animal.center.y - yMovingAmount);
    else animalBounceUp[boolIndex] = NO;
    
    if (!animalBounceUp[boolIndex] && animal.center.y < ANIMAL_MAX_BOUNCE_POINT) animal.center = CGPointMake(animal.center.x, animal.center.y + yMovingAmount);
    else animalBounceUp[boolIndex] = YES;
    
}

- (void) setInitValuesOfArrays
{
    animalRetrievedBoolValue[0] = NO;
    animalRetrievedBoolValue[1] = NO;
    animalRetrievedBoolValue[2] = NO;
    animalRetrievedBoolValue[3] = NO;
    animalRetrievedBoolValue[4] = NO;
    animalRetrievedBoolValue[5] = NO;
    
    animalIsInForeground[0] = YES;
    animalIsInForeground[1] = YES;
    animalIsInForeground[2] = NO;
    animalIsInForeground[3] = NO;
    animalIsInForeground[4] = NO;
    animalIsInForeground[5] = YES;
    
    animalBounceUp[0] = YES;
    animalBounceUp[1] = NO;
    animalBounceUp[2] = YES;
    animalBounceUp[3] = NO;
    animalBounceUp[4] = YES;
    animalBounceUp[5] = NO;
}

- (void) setInitValueOfAnimals
{
    self.CatView.transform = CGAffineTransformMakeScale(-0.6, 0.6);
    self.CatView.center = CGPointMake(280, self.CatView.center.y);
    
    self.DragonView.transform = CGAffineTransformMakeScale(-0.6, 0.6);
    self.DragonView.center = CGPointMake(512, self.DragonView.center.y);
    self.DragonView.alpha = 0.0;
    
    self.RabbitView.transform = CGAffineTransformMakeScale(-0.6, 0.6);
    self.RabbitView.center = CGPointMake(750, self.RabbitView.center.y);
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
    
    [self.voiceOverPlayer setAudioFile:@"19_VO.mp3"];
    [self.SFX01 setAudioFile:@"19_SFX01.mp3"];
	[self.SFX02 setAudioFile:@"19_carousel.mp3"];
    
	self.SFX02.repeats = YES;
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:29];
    
    [self setInitValueOfAnimals];
    
    [self setInitValuesOfArrays];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.BG = nil;
    self.Trunk = nil;
    self.Label = nil;
    self.StartAnimating = nil;
    self.FrogView = nil;
    self.FrogViewPole = nil;
    self.Frog = nil;
    self.DolphinView = nil;
    self.DolphinViewPole = nil;
    self.Dolphin = nil;
    self.CatView = nil;
    self.CatViewPole = nil;
    self.Cat = nil;
    self.DragonView = nil;
    self.DragonViewPole = nil;
    self.Dragon = nil;
    self.RabbitView = nil;
    self.RabbitViewPole = nil;
    self.Rabbit = nil;
    self.MushroomView = nil;
    self.MushroomViewPole = nil;
    self.Mushroom = nil;
    self.TopRoof = nil;
	
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
