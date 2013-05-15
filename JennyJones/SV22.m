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

@property (weak, nonatomic) IBOutlet UIImageView *CreditRoll;
@property (weak, nonatomic) IBOutlet OBShapedButton *RateUs;
@property (weak, nonatomic) IBOutlet OBShapedButton *Restart;

@property NSUserDefaults *defaults;

@end

@implementation SV22

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

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.defaults = [NSUserDefaults standardUserDefaults];
	
	[self.SFX07 setAudioFile:@"21_credits.mp3"];
	
	self.CreditRoll.frame = CGRectMake(self.CreditRoll.frame.origin.x, self.view.frame.size.height, self.CreditRoll.frame.size.width, self.CreditRoll.frame.size.height);
	self.RateUs.alpha = 0.0;
	self.Restart.alpha = 0.0;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX07 play];
	[UIView animateWithDuration:10.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.CreditRoll.center = CGPointMake(self.CreditRoll.center.x, self.view.frame.size.height / 2);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0 animations:^{
			self.RateUs.alpha = 1.0;
			self.Restart.alpha = 1.0;
		}];
	}];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[self setCreditRoll:nil];
	[self setRateUs:nil];
	[self setRestart:nil];
	
	self.defaults = nil;
}

@end
