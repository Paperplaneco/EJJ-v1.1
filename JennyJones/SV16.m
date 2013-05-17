//
//  SV16.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SV16.h"

@interface SV16 ()
{
    NSTimer *timer;
    NSTimer *canonTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *FG;
@property (weak, nonatomic) IBOutlet UIImageView *BlueParrot;
@property (weak, nonatomic) IBOutlet UIImageView *Muscles;
@property (weak, nonatomic) IBOutlet UIImageView *Uni;

@property (weak, nonatomic) IBOutlet UIView *BallerinaView;
@property (weak, nonatomic) IBOutlet UIImageView *Ballerina;

@property (weak, nonatomic) IBOutlet UIImageView *Canon01a;
@property (weak, nonatomic) IBOutlet UIImageView *Canon01b;
@property (weak, nonatomic) IBOutlet UIImageView *Canon02;

@property (weak, nonatomic) IBOutlet UIView *WheelView;
@property (weak, nonatomic) IBOutlet UIImageView *Wheel01;
@property (weak, nonatomic) IBOutlet UIImageView *Wheel02;
@property (weak, nonatomic) IBOutlet UIImageView *Wheel03_01;
@property (weak, nonatomic) IBOutlet UIImageView *Wheel03_02;

@property (weak, nonatomic) IBOutlet UIView *DonutView;
@property (weak, nonatomic) IBOutlet UIImageView *Donut01;
@property (weak, nonatomic) IBOutlet UIImageView *Donut02;

@property (weak, nonatomic) IBOutlet UIView *ClownView;
@property (weak, nonatomic) IBOutlet UIImageView *Clown01;
@property (weak, nonatomic) IBOutlet UIImageView *Clown02a;
@property (weak, nonatomic) IBOutlet UIImageView *Clown02b;
@property (weak, nonatomic) IBOutlet UIImageView *Clown02c;

@property (weak, nonatomic) IBOutlet UIView *DuckView;
@property (weak, nonatomic) IBOutlet UIImageView *Duck01;
@property (weak, nonatomic) IBOutlet UIImageView *Duck02;

@property (weak, nonatomic) IBOutlet UIView *RabbitView;
@property (weak, nonatomic) IBOutlet UIImageView *Rabbit01;
@property (weak, nonatomic) IBOutlet UIImageView *Rabbit02;
@property (weak, nonatomic) IBOutlet UIImageView *Rabbit03;
@property (weak, nonatomic) IBOutlet UILabel *Label01;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSUserDefaults *defaults;

@end

@implementation SV16

@synthesize defaults = _defaults;

- (IBAction)canonTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX03 setAudioFile:@"16_canon.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
	
    self.Canon01a.userInteractionEnabled = NO;
    [canonTimer invalidate];
    canonTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(canonFired) userInfo:nil repeats:YES];
}

- (void) canonFired
{
    float xMovingAmount = 4;
    float yMovingAmount = 2;
    
    self.Canon02.center = CGPointMake(self.Canon02.center.x + xMovingAmount, self.Canon02.center.y - yMovingAmount);
    
    if (self.Canon02.center.x > 1100 || self.Canon02.center.y < -50) [canonTimer invalidate];
}

- (IBAction)wheelTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX02 setAudioFile:@"16_wheel.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(0)];
    [rotationAnimation setToValue:DegreesToNumber(360)];
    [rotationAnimation setDuration:2];
    [rotationAnimation setRepeatCount:1];
    
    [self.Wheel02.layer addAnimation:rotationAnimation forKey:@"rotate"];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotation setFromValue:DegreesToNumber(0)];
    [rotation setToValue:DegreesToNumber(1440)];
    [rotation setDuration:2];
    [rotation setRepeatCount:1];
    
    [self.Wheel03_01.layer addAnimation:rotation forKey:@"wheelrotate"];
    [self.Wheel03_02.layer addAnimation:rotation forKey:@"wheelrotate"];
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

NSNumber* DegreesToNumber(CGFloat degrees)
{
    return [NSNumber numberWithFloat:
            DegreesToRadians(degrees)];
}

- (IBAction)ballerinaTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX04 setAudioFile:@"16_ballerina.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
	
    CABasicAnimation *balleriaAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    [balleriaAnimation setFromValue:DegreesToNumber(0)];
    [balleriaAnimation setToValue:DegreesToNumber(1440)];
    [balleriaAnimation setDuration:2];
    [balleriaAnimation setRepeatCount:1];
    
    [self.Ballerina.layer addAnimation:balleriaAnimation forKey:@"balleriarotate"];
}

- (IBAction)blueParrotTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX05 setAudioFile:@"16_parrot.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
	
    self.BlueParrot.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"16_BlueParrot01.png"],
                                       [UIImage imageNamed:@"16_BlueParrot02.png"],
                                       nil];
    self.BlueParrot.animationDuration = 0.5;
    self.BlueParrot.animationRepeatCount = 4;
    [self.BlueParrot startAnimating];
}

- (IBAction)musclesTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX06 setAudioFile:@"16_muscles.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX06 play];
	
    self.Muscles.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"16_Muscles01.png"],
                                    [UIImage imageNamed:@"16_Muscles02.png"],
                                    nil];
    self.Muscles.animationDuration = 0.5;
    self.Muscles.animationRepeatCount = 4;
    [self.Muscles startAnimating];
}

- (IBAction)uniTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX07 setAudioFile:@"16_uni.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX07 play];
	
    self.Uni.animationImages = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"16_Uni01.png"],
                                [UIImage imageNamed:@"16_Uni02.png"],
                                nil];
    self.Uni.animationDuration = 0.5;
    self.Uni.animationRepeatCount = 4;
    [self.Uni startAnimating];
}

- (IBAction)donutTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX02 setAudioFile:@"16_donut.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(0)];
    [rotationAnimation setToValue:DegreesToNumber(720)];
    [rotationAnimation setDuration:2];
    [rotationAnimation setRepeatCount:1];
    
    [self.Donut02.layer addAnimation:rotationAnimation forKey:@"rotate"];
    
    [self donutBounce];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(donutBounce) userInfo:nil repeats:NO];
}

- (void) donutBounce
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Donut02.center = CGPointMake(self.Donut02.center.x, self.Donut02.center.y - 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.Donut02.center = CGPointMake(self.Donut02.center.x, self.Donut02.center.y + 50);
        }];
    }];
}

- (IBAction)clownTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX03 setAudioFile:@"16_clown.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
	
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(0)];
    [rotationAnimation setToValue:DegreesToNumber(720)];
    [rotationAnimation setDuration:2];
    [rotationAnimation setRepeatCount:1];
    
    [self.Clown02a.layer addAnimation:rotationAnimation forKey:@"rotate"];
    [self.Clown02b.layer addAnimation:rotationAnimation forKey:@"rotate"];
    [self.Clown02c.layer addAnimation:rotationAnimation forKey:@"rotate"];
    
    [self clownBounce];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clownBounce) userInfo:nil repeats:NO];
}

- (void) clownBounce
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Clown02a.center = CGPointMake(self.Clown02a.center.x, self.Clown02a.center.y - 27);
        self.Clown02b.center = CGPointMake(self.Clown02b.center.x, self.Clown02b.center.y + 27);
        self.Clown02c.center = CGPointMake(self.Clown02c.center.x, self.Clown02c.center.y - 27);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.Clown02a.center = CGPointMake(self.Clown02a.center.x, self.Clown02a.center.y + 27);
            self.Clown02b.center = CGPointMake(self.Clown02b.center.x, self.Clown02b.center.y - 27);
            self.Clown02c.center = CGPointMake(self.Clown02c.center.x, self.Clown02c.center.y + 27);
        }];
    }];;
}

- (IBAction)duckTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX04 setAudioFile:@"16_duck.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
	
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(-40)];
    [rotationAnimation setToValue:DegreesToNumber(50)];
    [rotationAnimation setDuration:0.5];
    [rotationAnimation setAutoreverses:YES];
    [rotationAnimation setRepeatCount:4];
    
    [self.Duck02.layer addAnimation:rotationAnimation forKey:@"rotate"];
}

- (IBAction)rabbitTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX05 setAudioFile:@"16_rabbit.mp3"];
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
	
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(-50)];
    [rotationAnimation setToValue:DegreesToNumber(50)];
    [rotationAnimation setAutoreverses:YES];
    [rotationAnimation setDuration:0.5];
    [rotationAnimation setRepeatCount:4];
    rotationAnimation.delegate = self;
    [self.Rabbit02.layer addAnimation:rotationAnimation forKey:@"rotate"];
    
    canonTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(rabbitBlink) userInfo:nil repeats:YES];
}

- (void) rabbitBlink
{
    if (self.Rabbit03.hidden) self.Rabbit03.hidden = NO;
    else self.Rabbit03.hidden = YES;
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [canonTimer invalidate];
}

- (void) wheelMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.WheelView repeats:YES];
}

- (void) cannonMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.Canon01a repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.Canon01b repeats:YES];
    canonTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.Canon02 repeats:YES];
}

- (void) ballerinaMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.BallerinaView repeats:YES];
}

- (void) blueParrotMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.BlueParrot repeats:YES];
}

- (void) musclesMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.Muscles repeats:YES];
}

- (void) uniMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.Uni repeats:YES];
}

- (void) donutMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.DonutView repeats:YES];
}

- (void) clownMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.ClownView repeats:YES];
}

- (void) duckMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.DuckView repeats:YES];
}

- (void) rabbitMoving
{
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(circusMarching:) userInfo:self.RabbitView repeats:YES];
}

- (void) circusMarching: (NSTimer *) tmr
{
    float movingAmount = 1;
    
    UIImageView *img = [tmr userInfo];
    
    if (img.center.x < 1120) img.center = CGPointMake(img.center.x + movingAmount, img.center.y);
	else img.userInteractionEnabled = NO;
}

- (void) circusMarchingTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(wheelMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(cannonMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(ballerinaMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:9.0 target:self selector:@selector(blueParrotMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:12.0 target:self selector:@selector(musclesMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(uniMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:18.0 target:self selector:@selector(donutMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:21.0 target:self selector:@selector(clownMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:24.0 target:self selector:@selector(duckMoving) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:27.0 target:self selector:@selector(rabbitMoving) userInfo:nil repeats:NO];
}

- (void) setInitPositionOfCircusViews
{
    self.WheelView.center = CGPointMake(-80, self.WheelView.center.y);
    
    self.Canon01a.center = CGPointMake(-250, self.Canon01a.center.y);
    self.Canon01b.center = CGPointMake(-195, self.Canon01b.center.y);
    self.Canon02.center = CGPointMake(-190, self.Canon02.center.y);
    
    self.BallerinaView.center = CGPointMake(-85, self.BallerinaView.center.y);
    
    self.BlueParrot.center = CGPointMake(-85, self.BlueParrot.center.y);
    
    self.Muscles.center = CGPointMake(-100, self.Muscles.center.y);
    
    self.Uni.center = CGPointMake(-100, self.Uni.center.y);
    
    self.DonutView.center = CGPointMake(-50, self.DonutView.center.y);
    
    self.ClownView.center = CGPointMake(-80, self.ClownView.center.y);
    
    self.DuckView.center = CGPointMake(-80, self.DuckView.center.y);
    
    self.RabbitView.center = CGPointMake(-100, self.RabbitView.center.y);
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
    
    [self.voiceOverPlayer setAudioFile:@"16_VO.mp3"];
	[self.SFX01 setAudioFile:@"16_loop.mp3"];
	
	self.SFX01.repeats = YES;
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label01.font = [UIFont fontWithName:@"AFontwithSerifs" size:30];
    
    [self setInitPositionOfCircusViews];
    
    [self circusMarchingTimer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnBack.alpha = 0.25;
	self.btnNext.alpha = 0.25;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.BG = nil;
    self.FG = nil;
    self.BlueParrot = nil;
    self.Muscles = nil;
    self.Uni = nil;
    self.BallerinaView = nil;
    self.Ballerina = nil;
    self.Canon01a = nil;
    self.Canon01b = nil;
    self.Canon02 = nil;
    self.WheelView = nil;
    self.Wheel01 = nil;
    self.Wheel02 = nil;
    self.Wheel03_01 = nil;
    self.Wheel03_02 = nil;
    self.DonutView = nil;
    self.Donut01 = nil;
    self.Donut02 = nil;
    self.ClownView = nil;
    self.Clown01 = nil;
    self.Clown02a = nil;
    self.Clown02b = nil;
    self.Clown02c = nil;
    self.DuckView = nil;
    self.Duck01 = nil;
    self.Duck02 = nil;
    self.RabbitView = nil;
    self.Rabbit01 = nil;
    self.Rabbit02 = nil;
    self.Rabbit03 = nil;
    self.Label01 = nil;
    
    self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
	self.SFX03 = nil;
	self.SFX04 = nil;
	self.SFX05 = nil;
	self.SFX06 = nil;
	self.SFX07 = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
