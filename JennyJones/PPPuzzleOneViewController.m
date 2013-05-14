//
//  PPPuzzleOneViewController.m
//  JennyJones
//
//  Created by Corey Manders on 10/7/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPuzzleOneViewController.h"
#import "PPPuzzleEngine.h"
#import "PPWatchView.h"
#import "PPPuzzleTwoViewController.h"
#import "PPPhysicsUtility.h"
#import "PPHalfPageImageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PPRootView.h"
#define LEFT 0
#define RIGHT 1

@interface PPPuzzleOneViewController ()<PPPuzzleEngineDelegate>
@property (strong,nonatomic) PPPuzzleEngine * puzzleEngine;
@property PPWatchView *puzzleTimer;
@property (strong) PPPhysicsUtility * physicsUtility;
@property (strong) AVAudioPlayer * miaoPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_DimBackground;

@end 

@implementation PPPuzzleOneViewController
@synthesize PZL06_05a;
@synthesize PZL06_05b;
@synthesize PZL06_06a;
@synthesize PZL06_06b;
@synthesize PZL06_07a;
@synthesize PZL06_07b;
@synthesize PZL06_09a;
@synthesize PZL06_09b;
@synthesize PZL06_10a;
@synthesize PZL06_10b;
@synthesize PZL06_11a;
@synthesize PZL06_11b;
@synthesize PZL06_06c;
@synthesize PZL06_07c;
@synthesize PZL06_09c;
@synthesize PZL06_12c;
@synthesize PZL06_01c;
@synthesize PZL06_02c;
@synthesize PZL06_03c;
@synthesize PZL06_10c;
@synthesize PZL06_05c;
@synthesize PZL06_04c;
@synthesize PZL06_11c;
@synthesize PZL06_12a;
@synthesize PZL06_12b;
@synthesize PZL06_miaow02b;
@synthesize PZL06_miaow02a;
@synthesize puzzleTimer;
@synthesize PZL06_Reveal;
@synthesize PZL06_BG;
@synthesize PZL06_01a;
@synthesize PZL06_01b;
@synthesize PZL06_02a;
@synthesize PZL06_02b;
@synthesize PZL06_03a;
@synthesize PZL06_03b;
@synthesize PZL06_04a;
@synthesize PZL06_04b;
@synthesize pageNumber = _pagenumber;
@synthesize physicsUtility = _physicsUtility;
@synthesize puzzleEngine = _puzzleEngine;

- (IBAction)mrMeowTapped:(UITapGestureRecognizer *)sender {
    [self.puzzleEngine pulseObjects];
}


- (IBAction)timerLongPressed:(UILongPressGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan)
    [self.puzzleEngine reset];
}


-(void)reset
{
    [self.puzzleEngine reset];
}

-(void)resetMiaow
{
    [self.physicsUtility resetEffectedBody];
}

-(void)miaowAction{
    [self.physicsUtility applyForceToEffectedBody];
    [self.puzzleEngine giveHintUsingEmitter];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.miaoPlayer play];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetMiaow) userInfo:nil repeats:NO];

}

- (IBAction)miaow_tapped:(UITapGestureRecognizer *)sender {
    [self miaowAction];
}
- (IBAction)miaowBottomTapped:(UITapGestureRecognizer *)sender {
    [self miaowAction];
}

- (IBAction)doNothingTap:(UITapGestureRecognizer *)sender {
    //NSLog(@"doing nothing");
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
    }
    return self;
}



-(void)puzzleCompleted:(BOOL)complete
{

    NSNumber * previousTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle one time"];
    if (!previousTime)
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle one time"];
    else {
        if (self.puzzleTimer.timeTaken < [previousTime floatValue])
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle one time"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"puzzle one done"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
   
}

- (IBAction)puzzleInstructionTapped:(UITapGestureRecognizer *)sender
{
	self.PZL_Instruction.userInteractionEnabled = NO;
	self.PZL_DimBackground.hidden = YES;
	[UIView animateWithDuration:0.5 animations:^{
		self.PZL_Instruction.transform = CGAffineTransformMakeScale(0.0, 0.0);
	}];
	[self.puzzleEngine startTimer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self  reset];
    
    self.puzzleTimer = [[PPWatchView alloc] initWatchView];
    [self.view addSubview:self.puzzleTimer];
	
	self.PZL_Instruction.userInteractionEnabled = NO;
	self.PZL_DimBackground.alpha = 0.45;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.puzzleEngine = [[PPPuzzleEngine alloc] initWithBWObjects:
                         [NSArray arrayWithObjects:self.PZL06_01a, self.PZL06_02a, self.PZL06_03a,
                          self.PZL06_04a, self.PZL06_05a, self.PZL06_06a, self.PZL06_07a,
                          self.PZL06_09a, self.PZL06_10a, self.PZL06_11a, self.PZL06_12a, nil]
                                                            color:[NSArray arrayWithObjects:self.PZL06_01b, self.PZL06_02b, self.PZL06_03b,
                                                                   self.PZL06_04b, self.PZL06_05b, self.PZL06_06b, self.PZL06_07b,
                                                                   self.PZL06_09b, self.PZL06_10b, self.PZL06_11b,self.PZL06_12b, nil]
                                                         bwSquare:[NSArray arrayWithObjects:self.PZL06_01c, self.PZL06_02c, self.PZL06_03c,
                                                                   self.PZL06_04c, self.PZL06_05c, self.PZL06_06c, self.PZL06_07c,
                                                                   self.PZL06_09c, self.PZL06_10c, self.PZL06_11c,self.PZL06_12c, nil]
                                                       backgound1:self.PZL06_BG background2:nil background3:nil reveal1:self.PZL06_Reveal reveal2:nil reveal3:nil];
    
    self.navigationController.navigationBar.hidden = YES;
    self.puzzleEngine.numberOfHiddenObjects = 3;
    self.puzzleEngine.numberOfMusicFiles = 15;
    self.puzzleEngine.hostView= self.view;
    self.puzzleEngine.puzzleTimer = self.puzzleTimer;
    self.puzzleEngine.puzzleTime = 90.0;
    self.puzzleEngine.delegate = self;
    [self.puzzleEngine startEngine];
    
    //set up the physicsEngine
    self.physicsUtility = [[PPPhysicsUtility alloc] init];
    self.physicsUtility.hostview = self.view;
    self.physicsUtility.effectedBody = self.PZL06_miaow02a;
    [self.physicsUtility startPhysicsEngine];
	
	self.PZL_Instruction.transform = CGAffineTransformMakeScale(0.1, 0.1);
	
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.PZL_Instruction.transform = CGAffineTransformMakeScale(1.3, 1.3);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
			self.PZL_Instruction.transform = CGAffineTransformMakeScale(1.0, 1.0);
		} completion:^(BOOL finished) {
			self.PZL_Instruction.userInteractionEnabled = YES;
		}];
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.trackedViewName = @"Dining Room Puzzle";
	
    //set up the miao sound
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MrMiaow.mp3", [[NSBundle mainBundle] resourcePath]]];
    [self.miaoPlayer prepareToPlay];
	
	NSError *error;
    self.miaoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPZL06_Reveal:nil];
    [self setPZL06_BG:nil];
    [self setPZL06_01a:nil];
    [self setPZL06_01b:nil];
    [self setPZL06_02a:nil];
    [self setPZL06_02b:nil];
    [self setPZL06_03a:nil];
    [self setPZL06_03b:nil];
    [self setPZL06_04a:nil];
    [self setPZL06_04b:nil];
    [self setPZL06_06a:nil];
    [self setPZL06_05b:nil];
    [self setPZL06_06a:nil];
    [self setPZL06_06b:nil];
    [self setPZL06_07a:nil];
    [self setPZL06_07b:nil];
    [self setPZL06_09a:nil];
    [self setPZL06_09b:nil];
    [self setPZL06_10a:nil];
    [self setPZL06_10b:nil];
    [self setPZL06_11a:nil];
    [self setPZL06_11b:nil];
    [self setPuzzleTimer:nil];
    [self setPZL06_06c:nil];
    [self setPZL06_07c:nil];
    [self setPZL06_09c:nil];
    [self setPZL06_12c:nil];
    [self setPZL06_01c:nil];
    [self setPZL06_02c:nil];
    [self setPZL06_03c:nil];
    [self setPZL06_10c:nil];
    [self setPZL06_05c:nil];
    [self setPZL06_04c:nil];
    [self setPZL06_11c:nil];
    [self setPZL06_12a:nil];
    [self setPZL06_12b:nil];
    [self setPZL06_miaow02b:nil];
    [self setPZL06_miaow02a:nil];
    [super viewDidUnload];
    NSLog(@"first puzzle unloaded");
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
        interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
	return NO;
}

@end
