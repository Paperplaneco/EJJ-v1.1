//
//  PPAnimatingViewController.h
//  JennyJones
//
//  Created by Zune Moe on 17/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPAudioPlayer.h"
#import "GAITrackedViewController.h"


@interface PPAnimatingViewController : GAITrackedViewController <AVAudioPlayerDelegate>

@property (strong) PPAudioPlayer *voiceOverPlayer;
@property (strong) PPAudioPlayer *revealPlayer;

@property (strong) PPAudioPlayer *SFX01;
@property (strong) PPAudioPlayer *SFX02;
@property (strong) PPAudioPlayer *SFX03;
@property (strong) PPAudioPlayer *SFX04;
@property (strong) PPAudioPlayer *SFX05;
@property (strong) PPAudioPlayer *SFX06;
@property (strong) PPAudioPlayer *SFX07;

- (IBAction)btnPrev_Tapped:(UITapGestureRecognizer *)sender;
- (IBAction)btnNext_Tapped:(UITapGestureRecognizer *)sender;

@end
