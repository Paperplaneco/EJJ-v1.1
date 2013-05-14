//
//  SV03.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV03.h"

@interface SV03 ()

@property (weak, nonatomic) IBOutlet UIView *ViewAContainer;
@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIImageView *Bird;
@property (weak, nonatomic) IBOutlet UIImageView *Plane;

@property (weak, nonatomic) IBOutlet UIView *ViewBContainer;
@property (weak, nonatomic) IBOutlet UILabel *Labelb;
@property (weak, nonatomic) IBOutlet UIImageView *Planeb;
@property (weak, nonatomic) IBOutlet UIImageView *Birdb;
@property (weak, nonatomic) IBOutlet UIImageView *Smoke;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo1;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo2;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo3;
@property (weak, nonatomic) IBOutlet UIImageView *Flamingo4;

@property (weak, nonatomic) IBOutlet UIView *ViewCContainer;
@property (weak, nonatomic) IBOutlet UILabel *Labelc;
@property (weak, nonatomic) IBOutlet UILabel *Labelc1;
@property (weak, nonatomic) IBOutlet UIImageView *Planec;
@property (weak, nonatomic) IBOutlet UIImageView *Birdc;
@property (weak, nonatomic) IBOutlet UIImageView *Boat;
@property (weak, nonatomic) IBOutlet UIImageView *Car1;
@property (weak, nonatomic) IBOutlet UIImageView *Car2;
@property (weak, nonatomic) IBOutlet UIImageView *Car3;
@property (weak, nonatomic) IBOutlet UIImageView *Car4;

@property NSUserDefaults *defaults;

@end

@implementation SV03

@synthesize defaults = _defaults;

/*
 View A actions
 */

- (IBAction)bgTapped:(UITapGestureRecognizer *)sender
{
    CATransition *transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionFade;
    transition.duration = 1.0;
    
    [self.ViewAContainer.layer addAnimation:transition forKey:@"transition"];
    [self.ViewBContainer.layer addAnimation:transition forKey:@"transition"];
    
    self.ViewAContainer.hidden = YES;
    self.ViewBContainer.hidden = NO;
    
    // Animate things from View B
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(viewB_BirdAndPlaneMoving) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(smokeAndFlamingosAnimate) userInfo:nil repeats:NO];
    
    [self.voiceOverPlayer setAudioFile:@"03b_VO.mp3"];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
}

- (void) birdAndPlaneMoving
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Bird.center = CGPointMake (1100, 167);
    } completion:nil];
    [UIView animateWithDuration:7 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Plane.center = CGPointMake (1100, 206);
    } completion:nil];
}

/*
 View B Actions
 */

- (IBAction)viewBTapped:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionFade;
    transition.duration = 1.0;
    
    [self.ViewBContainer.layer addAnimation:transition forKey:@"transition"];
    [self.ViewCContainer.layer addAnimation:transition forKey:@"transition"];
    
    self.ViewBContainer.hidden = YES;
    self.ViewCContainer.hidden = NO;
    
    // Animate things from View C
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(boatMove) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(carOneMove) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(carTwoMove) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(carThreeMove) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(carFourMove) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ViewC_BirdAndPlaneMoving) userInfo:nil repeats:NO];
    
    [self.voiceOverPlayer setAudioFile:@"03c_VO.mp3"];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
}

- (void) viewB_BirdAndPlaneMoving
{
	self.SFX01.volume = 0.4;
	self.SFX02.volume = 0.6;
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Birdb.center = CGPointMake(1100, 120);
    } completion:nil];
    [UIView animateWithDuration:6.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Planeb.center = CGPointMake(1100, 162);
    } completion:nil];
}

- (void) smokeAndFlamingosAnimate
{
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat animations:^{
        self.Smoke.alpha = 0.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat animations:^{
        self.Flamingo1.center = CGPointMake(self.Flamingo1.center.x, self.Flamingo1.center.y + 10);
        self.Flamingo2.center = CGPointMake(self.Flamingo2.center.x, self.Flamingo2.center.y + 10);
        self.Flamingo3.center = CGPointMake(self.Flamingo3.center.x, self.Flamingo3.center.y + 10);
        self.Flamingo4.center = CGPointMake(self.Flamingo4.center.x, self.Flamingo4.center.y + 10);
    } completion:nil];
}

/*
 View C Actions
 */

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

- (void) ViewC_BirdAndPlaneMoving
{
	[self.SFX01 setAudioFile:@"03_BG02.mp3"];
	self.SFX01.volume = 1.0;
	self.SFX02.volume = 0.35;
	
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

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.trackedViewName = @"Ordinary world";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"03a_VO.mp3"];
	[self.SFX01 setAudioFile:@"03_BG01.mp3"];
	[self.SFX02 setAudioFile:@"03_birdplane.mp3"];
	
	self.SFX01.volume = 0.2;
	self.SFX02.volume = 1.0;
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    self.Labelb.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    self.Labelc.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    self.Labelc1.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    
    [self birdAndPlaneMoving];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setBG:nil];
    [self setLabel:nil];
    [self setBird:nil];
    [self setPlane:nil];
    
    self.Labelb = nil;
    self.Planeb = nil;
    self.Birdb = nil;
    self.Smoke = nil;
    self.Flamingo1 = nil;
    self.Flamingo2 = nil;
    self.Flamingo3 = nil;
    self.Flamingo4 = nil;
    
    self.Labelc = nil;
    self.Labelc1 = nil;
    self.Planec = nil;
    self.Birdc = nil;
    self.Boat = nil;
    self.Car1 = nil;
    self.Car2 = nil;
    self.Car3 = nil;
    self.Car4 = nil;
    
    self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
    
    self.defaults = nil;
}
@end
