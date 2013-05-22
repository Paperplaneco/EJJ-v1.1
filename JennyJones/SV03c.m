//
//  SV03c.m
//  JennyJones
//
//  Created by Zune Moe on 14/5/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV03c.h"

@interface SV03c ()

@property (weak, nonatomic) IBOutlet UILabel *Labelc;
@property (weak, nonatomic) IBOutlet UILabel *Labelc1;
@property (weak, nonatomic) IBOutlet UIImageView *Planec;
@property (weak, nonatomic) IBOutlet UIImageView *Birdc;
@property (weak, nonatomic) IBOutlet UIImageView *Boat;
@property (weak, nonatomic) IBOutlet UIImageView *Car1;
@property (weak, nonatomic) IBOutlet UIImageView *Car2;
@property (weak, nonatomic) IBOutlet UIImageView *Car3;
@property (weak, nonatomic) IBOutlet UIImageView *Car4;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV03c

@synthesize defaults = _defaults;

- (void) boatMove
{
    self.Boat.hidden = NO;
	[UIView animateWithDuration:5.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.Boat.center = CGPointMake(396, 474);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.8 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
			self.Boat.transform = CGAffineTransformMakeRotation(-25 / 180.0 * M_PI);
			self.Boat.center = CGPointMake(420, 434);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
				self.Boat.transform = CGAffineTransformMakeRotation(15 / 180.0 * M_PI);
				self.Boat.center = CGPointMake(553, 360);
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
					self.Boat.center = CGPointMake(723, 308);
				} completion:^(BOOL finished) {
					[UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
						self.Boat.transform = CGAffineTransformMakeRotation(-35 / 180.0 * M_PI);
						self.Boat.center = CGPointMake(757, 216);
					} completion:^(BOOL finished) {
						[UIView animateWithDuration:4.5 animations:^{
							self.Boat.transform = CGAffineTransformMakeRotation(20 / 180.0 * M_PI);
							self.Boat.center = CGPointMake(1100, 100);
						}];
					}];
				}];
			}];
		}];
	}];
}

- (void) carOneMove
{
    [UIView animateWithDuration:15 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Car1.center = CGPointMake(486, 374);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:6 delay:-2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.Car1.center = CGPointMake(330, 356);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:7 delay:-2 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Car1.center = CGPointMake(122, 288);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:7 delay:-2 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.Car1.center = CGPointMake(-50, 210);
                } completion:nil];
            }];
        }];
    }];
}

- (void) carTwoMove
{
    [UIView animateWithDuration:6 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Car2.center = CGPointMake(486, 365);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:7 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.Car2.center = CGPointMake(330, 355);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:6 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Car2.center = CGPointMake(122, 285);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.Car2.center = CGPointMake(-50, 195);
                } completion:nil];
            }];
        }];
    }];
}

- (void) carThreeMove
{
    [UIView animateWithDuration:3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Car3.center = CGPointMake(486, 374);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.Car3.center = CGPointMake(330, 355);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Car3.center = CGPointMake(122, 285);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:6 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.Car3.center = CGPointMake(-50, 185);
                } completion:nil];
            }];
        }];
    }];
}

- (void) carFourMove
{
    [UIView animateWithDuration:3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Car4.center = CGPointMake(-40, 190);
    } completion:nil];
}

- (void) birdAndPlaneMove
{	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    [UIView animateWithDuration:4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Birdc.center = CGPointMake(1100, 78);
    } completion:nil];
    [UIView animateWithDuration:5.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Planec.center = CGPointMake(1100, 95);
    } completion:nil];
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
		self.btnNext.alpha = 1.0;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"03c_VO.mp3"];
	[self.SFX01 setAudioFile:@"03_BG02.mp3"];
	
	self.SFX01.volume = 1.0;
	self.SFX02.volume = 0.35;
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
	
	self.Labelc.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    self.Labelc1.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
	
	[self boatMove];
	[self carOneMove];
	[self carTwoMove];
	[self carThreeMove];
	[self carFourMove];
	[self birdAndPlaneMove];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	self.Labelc = nil;
    self.Labelc1 = nil;
    self.Planec = nil;
    self.Birdc = nil;
    self.Boat = nil;
    self.Car1 = nil;
    self.Car2 = nil;
    self.Car3 = nil;
    self.Car4 = nil;
	
	self.btnBack = nil;
	self.btnNext = nil;
	
	self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
	
	self.defaults = nil;
}

@end
