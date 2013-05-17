//
//  SV22.m
//  JennyJones
//
//  Created by Zune Moe on 15/5/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV22.h"
#import "OBShapedButton.h"

@interface SV22 ()
{
	float scale;
    NSTimer *basketTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *CreditRoll;
@property (weak, nonatomic) IBOutlet OBShapedButton *RateUs;
@property (weak, nonatomic) IBOutlet OBShapedButton *Restart;
@property (weak, nonatomic) IBOutlet UIImageView *ferrisLight;
@property (weak, nonatomic) IBOutlet UIImageView *tentLights01;
@property (weak, nonatomic) IBOutlet UIImageView *tentLights02;
@property (weak, nonatomic) IBOutlet UIImageView *basket;
@property (weak, nonatomic) IBOutlet OBShapedButton *btnBack;

@property (nonatomic) NSTimer *basketTimer;
@property NSUserDefaults *defaults;

@end

@implementation SV22

@synthesize basketTimer = _basketTimer;
@synthesize defaults = _defaults;

- (IBAction)rateUs:(id)sender {
	NSString *REVIEW_URL = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=633392398&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:REVIEW_URL]];
}

- (IBAction)startAgain:(id)sender {
	[self.defaults setInteger:0 forKey:@"user selected page"];
	
	[self.defaults setObject:@"NO" forKey:@"puzzle one done"];
	[self.defaults setObject:@"NO" forKey:@"puzzle two done"];
	[self.defaults setObject:@"NO" forKey:@"puzzle three done"];
	[self.defaults setObject:@"NO" forKey:@"puzzle ten done"];
	
	[self.defaults synchronize];
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}

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
    self.basket.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void) lightsStartTwinkling
{
    // Lights twinkling
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(lightsTwinkling:) userInfo:self.tentLights01 repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(lightsTwinkling:) userInfo:self.tentLights02 repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(lightsTwinkling:) userInfo:self.ferrisLight repeats:YES];
}

- (void) navShow:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		[self.SFX07 stop];
	}
	else
	{		
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
			[self.SFX07 play];
	}
}

- (void) voiceoverPlayerFinishPlaying:(NSNotification *) pNotification
{
	NSString *message = (NSString *) [pNotification object];
	if ([message isEqualToString:@"YES"])
	{
		self.btnBack.alpha = 1.0;
		self.btnBack.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.defaults = [NSUserDefaults standardUserDefaults];
	
	[self.SFX07 setAudioFile:@"21_credits.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX07 play];
	
	scale = 1.0;
    
    self.basket.layer.anchorPoint = CGPointMake(0, 0);
    self.basket.frame = CGRectMake(0, 0, self.basket.frame.size.width, self.basket.frame.size.height);
    
    [self lightsStartTwinkling];
    
    self.basketTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(basketMoving) userInfo:nil repeats:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[self setCreditRoll:nil];
	[self setRateUs:nil];
	[self setRestart:nil];
	[self setFerrisLight:nil];
	[self setTentLights01:nil];
	[self setTentLights02:nil];
	[self setBasket:nil];
	
	self.basketTimer = nil;
	self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[super viewDidUnload];
}
@end
