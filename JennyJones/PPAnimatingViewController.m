//
//  PPAnimatingViewController.m
//  JennyJones
//
//  Created by Zune Moe on 17/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPAnimatingViewController.h"

@implementation PPAnimatingViewController

@synthesize voiceOverPlayer = _voiceOverPlayer;
@synthesize revealPlayer = _revealPlayer;
@synthesize SFX01 = _SFX01;
@synthesize SFX02 = _SFX02;
@synthesize SFX03 = _SFX03;
@synthesize SFX04 = _SFX04;
@synthesize SFX05 = _SFX05;
@synthesize SFX06 = _SFX06;
@synthesize SFX07 = _SFX07;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)btnPrev_Tapped:(UITapGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"back"];
}

- (IBAction)btnNext_Tapped:(UITapGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"forward"];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
    self.voiceOverPlayer = [[PPAudioPlayer alloc] init];
    self.revealPlayer = [[PPAudioPlayer alloc] init];
    self.SFX01 = [[PPAudioPlayer alloc] init];
    self.SFX02 = [[PPAudioPlayer alloc] init];
    self.SFX03 = [[PPAudioPlayer alloc] init];
    self.SFX04 = [[PPAudioPlayer alloc] init];
    self.SFX05 = [[PPAudioPlayer alloc] init];
    self.SFX06 = [[PPAudioPlayer alloc] init];
    self.SFX07 = [[PPAudioPlayer alloc] init];

}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
    self.voiceOverPlayer = nil;
    self.revealPlayer = nil;
    
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
    self.SFX04 = nil;
    self.SFX05 = nil;
    self.SFX06 = nil;
    self.SFX07 = nil;

}

@end
