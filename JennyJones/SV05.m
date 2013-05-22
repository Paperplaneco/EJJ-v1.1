//
//  SV05.m
//  JennyJones
//
//  Created by Paperplane 1 on 14/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV05.h"

@interface SV05 ()
{
    CGPoint currentTouch;
    CGPoint lastTouch;
    double totalDis;
    int percentCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG_01;
@property (weak, nonatomic) IBOutlet UIImageView *BG_02;
@property (weak, nonatomic) IBOutlet UIImageView *CloudsL;
@property (weak, nonatomic) IBOutlet UIImageView *CloudsR;
@property (weak, nonatomic) IBOutlet UIImageView *Miao_01;
@property (weak, nonatomic) IBOutlet UIImageView *Miao_02;
@property (weak, nonatomic) IBOutlet UILabel *Label_01;
@property (weak, nonatomic) IBOutlet UILabel *Label_02;
@property (weak, nonatomic) IBOutlet UIImageView *Moon;

@property (weak, nonatomic) IBOutlet UIButton *Btn_Back;
@property (weak, nonatomic) IBOutlet UIButton *Btn_Next;

@property BOOL soundPlayed;
@property UIImageView *canvasView;
@property UIImageView *scratchView;

@property NSUserDefaults *defaults;

@end

@implementation SV05

@synthesize soundPlayed = _soundPlayed;
@synthesize canvasView, scratchView;
@synthesize defaults = _defaults;

- (IBAction)moonTapped:(UITapGestureRecognizer *)sender
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
	
    self.Moon.userInteractionEnabled = NO;
    [UIView animateWithDuration:3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = self.CloudsL.frame;
        frame.origin = CGPointMake(-280, 0);
        self.CloudsL.frame = frame;
    }completion:^(BOOL finished) {
        self.CloudsL.hidden = YES;
        self.Miao_01.hidden = YES;
        self.Miao_02.hidden = NO;
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
    }];
    [UIView animateWithDuration:7.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rFrame = self.CloudsR.frame;
        rFrame.origin = CGPointMake(750, 0);
        self.CloudsR.frame = rFrame;
    }completion:^(BOOL finished) {
        self.CloudsR.hidden = YES;
        self.CloudsR.center = CGPointMake(-100, -100);
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        self.BG_02.userInteractionEnabled = YES;
//        [self.BG_02 addGestureRecognizer:pan];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.BG_02.image.size.width, self.BG_02.image.size.height)];
        imageView.image = self.BG_02.image;
        [self.view addSubview:imageView];
        
        CGRect maskViewRect = CGRectMake(0, 0, self.BG_02.image.size.width, self.BG_02.image.size.height);
        
        ImageMaskView *maskView = [[ImageMaskView alloc] initWithFrame:maskViewRect image:self.BG_01.image];
        maskView.imageMaskFilledDelegate = self;
        [self.view addSubview:maskView];
        
        [self.view bringSubviewToFront:self.Btn_Back];
        [self.view bringSubviewToFront:self.Btn_Next];
        [self.view bringSubviewToFront:self.Miao_02];
        [self.view bringSubviewToFront:self.Label_01];
    }];
}

- (void) pan: (UIPanGestureRecognizer *) sender
{
    //currentTouch = [sender locationInView: self.BG_02];
    currentTouch = [sender locationInView: self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) lastTouch = currentTouch;
    
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGFloat brushSize = 70;
        CGColorRef strokeColor = [UIColor whiteColor].CGColor;

        UIGraphicsBeginImageContext(self.BG_02.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.BG_01.image drawInRect:CGRectMake(0, 0, self.BG_01.frame.size.width, self.BG_01.frame.size.height)];
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, brushSize);
        CGContextSetStrokeColorWithColor(context, strokeColor);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, lastTouch.x, lastTouch.y);
        CGContextAddLineToPoint(context, currentTouch.x, currentTouch.y);
        CGContextStrokePath(context);
        self.BG_01.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        double distance = sqrt(pow(currentTouch.x - lastTouch.x, 2) + pow(currentTouch.y - lastTouch.y, 2));
        totalDis += distance;
        lastTouch = currentTouch;
        NSLog(@"distance: %g", totalDis);
        
        if (!self.soundPlayed && totalDis > 10000)
        {
            [self.voiceOverPlayer setAudioFile:@"05b_VO.mp3"];
            if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
            if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
            self.Label_01.hidden = YES;
            self.Label_02.hidden = NO;
            [self.view bringSubviewToFront:self.Label_02];
            self.soundPlayed = YES;
        }
    }
}

#pragma mark - ImageMaskFilledDelegate

- (void) currentCGPoint:(CGPoint)currentPoint
{
    if (CGRectContainsPoint(self.Moon.frame, currentPoint) && !self.soundPlayed)
    {
        [self.voiceOverPlayer setAudioFile:@"05b_VO.mp3"];
        if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
        self.Label_01.hidden = YES;
        self.Label_02.hidden = NO;
        [self.view bringSubviewToFront:self.Label_02];
        self.soundPlayed = YES;
    }
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
		self.Btn_Next.alpha = 1.0;
		self.Btn_Next.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"05a_VO.mp3"];
    [self.SFX01 setAudioFile:@"05_SFX01.mp3"];
    [self.SFX02 setAudioFile:@"05_SFX02.mp3"];
    [self.SFX03 setAudioFile:@"05_SFX03.mp3"];
    [self.SFX04 setAudioFile:@"05_clouds.mp3"];
	
    self.SFX01.repeats = YES;
    self.SFX02.repeats = YES;
    
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    
    self.Moon.userInteractionEnabled = YES;
    
    self.Label_01.font = [UIFont fontWithName:@"AFontwithSerifs" size:29];
    self.Label_02.font = [UIFont fontWithName:@"AFontwithSerifs" size:32];
    
    totalDis = 0.0;
    percentCount = 0;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.Btn_Next.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setBG_01:nil];
    [self setBG_02:nil];
    [self setCloudsL:nil];
    [self setCloudsR:nil];
    [self setMiao_01:nil];
    [self setMiao_02:nil];
    [self setLabel_01:nil];
    [self setLabel_02:nil];
    [self setMoon:nil];
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
	self.SFX04 = nil;
    
    self.defaults = nil;
}

@end
