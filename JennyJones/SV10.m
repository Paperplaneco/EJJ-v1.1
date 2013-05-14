//
//  SV10.m
//  JennyJones
//
//  Created by Zune Moe on 21/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV10.h"

@interface SV10 ()

@property (weak, nonatomic) IBOutlet UIImageView *Table01;
@property (weak, nonatomic) IBOutlet UIImageView *Table02;
@property (weak, nonatomic) IBOutlet UILabel *Label;

@property NSUserDefaults *defaults;

@end

@implementation SV10

@synthesize defaults = _defaults;

- (IBAction)tableTapped:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:1.5 animations:^{
        self.Table01.alpha = 0.0;
        self.Table02.alpha = 1.0;
    }];
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

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.trackedViewName = @"Table shapes";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"10_VO.mp3"];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:36];
    
    self.Table01.alpha = 1.0;
    self.Table02.alpha = 0.0;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.Table01 = nil;
    self.Table02 = nil;
    self.Label = nil;
    
    self.voiceOverPlayer = nil;
    
    self.defaults = nil;
}

@end
