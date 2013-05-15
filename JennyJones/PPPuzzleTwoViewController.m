//
//  PPPuzzleTwoViewController.m
//  JennyJones
//
//  Created by Chrissy Lim on 18/7/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPuzzleTwoViewController.h"
#import "PPWatchView.h"
#import "PPPuzzleEngine.h"
#import <AVFoundation/AVFoundation.h>
#import "Chipmunk-iPhone/chipmunk.h"
#import "PPPhysicsUtility.h"
#import "PPRootView.h"
#import "PPHalfPageImageViewController.h"

@interface PPPuzzleTwoViewController ()<PPPuzzleEngineDelegate>

@property PPWatchView *puzzleTimer;
@property (weak, nonatomic) IBOutlet UIImageView *hiddenImage;
@property (strong) AVAudioPlayer * miaoPlayer;
@property (strong) PPPuzzleEngine * puzzleEngine;
@property (strong) PPPhysicsUtility * physicsUtility;

@property (weak, nonatomic) IBOutlet UIImageView *PZL_DimBackground;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Play;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Skip;
 
@end

@implementation PPPuzzleTwoViewController
@synthesize puzzleTimer;
@synthesize hiddenImage;
@synthesize puzzleEngine = _puzzleEngine;
@synthesize PZL07_miaow02a;
@synthesize miaoPlayer = _miaoPlayer;
@synthesize PZL07_BG01;
@synthesize PZL07_BG02;
@synthesize PZL07_01a;
@synthesize PZL07_01b;
@synthesize PZL07_01c;
@synthesize PZL07_02a;
@synthesize PZL07_02b;
@synthesize PZL07_02c;
@synthesize PZL07_03a;
@synthesize PZL07_03b;
@synthesize PZL07_03c;
@synthesize PZL07_04c;
@synthesize PZL07_04b;
@synthesize PZL07_04a;
@synthesize PZL07_05c;
@synthesize PZL07_05b;
@synthesize PZL07_05a;
@synthesize PZL07_06c;
@synthesize PZL07_06b;
@synthesize PZL07_06a;
@synthesize PZL07_07c;
@synthesize PZL07_07b;
@synthesize PZL07_07a;
@synthesize PZL07_08c;
@synthesize PZL07_08b;
@synthesize PZL07_08a;
@synthesize PZL07_09c;
@synthesize PZL07_09b;
@synthesize PZL07_09a;
@synthesize PZL07_10c;
@synthesize PZL07_10b;
@synthesize PZL07_10a;
@synthesize PZL07_11c;
@synthesize PZL07_11b;
@synthesize PZL07_11a;
@synthesize PZL07_12c;
@synthesize PZL07_12b;
@synthesize PZL07_12a;
@synthesize PZL07_13c;
@synthesize PZL07_13b;
@synthesize PZL07_13a;
@synthesize PZL07_14c;
@synthesize PZL07_14b;
@synthesize PZL07_14a;
@synthesize PZL07_15c;
@synthesize PZL07_15b;
@synthesize PZL07_15a;
@synthesize PZL07_18c;
@synthesize PZL07_18b;
@synthesize PZL07_18a;
@synthesize PZL07_19c;
@synthesize PZL07_19b;
@synthesize PZL07_19a;
@synthesize PZL07_miaow01;
@synthesize PZL07_miaow02b;
@synthesize PZL07_17c;
@synthesize PZL07_17b;
@synthesize PZL07_17a;
@synthesize physicsUtility = _physicsUtility;

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    PPRootView * vc =[segue destinationViewController];
//    vc.viewControllers = [NSArray arrayWithObjects:@"front page left", @"front page right", @"textpage3", @"textpage4", @"back page left",@"back page right",nil];
//    //vc.rightSideSegueName = @"toPuzzleThree";
//}

-(void) puzzleCompleted:(BOOL)complete
{
    self.PZL07_miaow02a.hidden = YES;
    self.PZL07_miaow02b.hidden = YES;
    self.PZL07_miaow01.hidden = YES;
    
    NSNumber * previousTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two time"];
    if (!previousTime)
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle two time"];
    else {
        if (self.puzzleTimer.timeTaken < [previousTime floatValue])
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle two time"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"puzzle two done"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.puzzleTimer.alpha = 0.0;
    }completion:^(BOOL finished){

        [self dismissModalViewControllerAnimated:NO];
        
    }];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) resetMiaow
{
    self.PZL07_miaow01.hidden = NO;
    self.PZL07_miaow02b.hidden = YES;
    self.PZL07_miaow02a.hidden = YES;
    [self.physicsUtility resetEffectedBody];

}

-(void) miaowTapped:(UITapGestureRecognizer*)sender
{
    
    if (self.puzzleTimer.currentCount >0){
        self.PZL07_miaow01.hidden = YES;
        self.PZL07_miaow02b.hidden = NO;
        self.PZL07_miaow02a.hidden = NO;
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.miaoPlayer play];
        
        [self.puzzleEngine giveHintUsingEmitter];
        [self.physicsUtility applyForceToEffectedBody];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetMiaow) userInfo:nil repeats:NO];
    }
    

}

 

- (IBAction)timerLongpress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
        [self.puzzleEngine reset];
}

- (IBAction)puzzleInstructionTapped:(UITapGestureRecognizer *)sender
{
	self.PZL_Instruction.userInteractionEnabled = NO;
	self.PZL_DimBackground.hidden = YES;
	[UIView animateWithDuration:0.5 animations:^{
		[self puzzleInstructionImageTransformScale:0.0];
	}];
	[self.puzzleEngine startTimer];
}

- (IBAction)puzzleInstructionSkipped:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void) puzzleInstructionImageTransformScale: (float) x
{
	self.PZL_Instruction.transform = CGAffineTransformMakeScale(x, x);
	self.PZL_Instruction_Play.transform = CGAffineTransformMakeScale(x, x);
	self.PZL_Instruction_Skip.transform = CGAffineTransformMakeScale(x, x);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.puzzleEngine reset];
    
    self.puzzleTimer = [[PPWatchView alloc] initWatchView];
    [self.view addSubview:self.puzzleTimer];
	
	self.PZL_DimBackground.alpha = 0.45;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.puzzleEngine = [[PPPuzzleEngine alloc] initWithBWObjects:
                         [NSArray arrayWithObjects:self.PZL07_01a, self.PZL07_02a, self.PZL07_03a,
                          self.PZL07_04a, self.PZL07_05a, self.PZL07_06a, self.PZL07_07a, self.PZL07_08a,
                          self.PZL07_09a, self.PZL07_10a, self.PZL07_11a, self.PZL07_12a,
                          self.PZL07_13a, self.PZL07_14a, self.PZL07_15a,
                          self.PZL07_17a, self.PZL07_18a, self.PZL07_19a,
                          nil]
                                                            color:[NSArray arrayWithObjects:self.PZL07_01b, self.PZL07_02b, self.PZL07_03b,
                                                                   self.PZL07_04b, self.PZL07_05b, self.PZL07_06b, self.PZL07_07b, self.PZL07_08b,
                                                                   self.PZL07_09b, self.PZL07_10b, self.PZL07_11b, self.PZL07_12b,
                                                                   self.PZL07_13b, self.PZL07_14b, self.PZL07_15b,
                                                                   self.PZL07_17b, self.PZL07_18b, self.PZL07_19b,
                                                                   nil]
                                                         bwSquare:[NSArray arrayWithObjects:self.PZL07_01c, self.PZL07_02c, self.PZL07_03c,
                                                                   self.PZL07_04c, self.PZL07_05c, self.PZL07_06c, self.PZL07_07c, self.PZL07_08c,
                                                                   self.PZL07_09c, self.PZL07_10c, self.PZL07_11c, self.PZL07_12c,
                                                                   self.PZL07_13c, self.PZL07_14c, self.PZL07_15c,
                                                                   self.PZL07_17c, self.PZL07_18c, self.PZL07_19c, nil]
                         
                                                       backgound1:self.PZL07_BG01 background2:nil background3:nil reveal1:self.PZL07_BG02 reveal2:nil reveal3:nil];
    
    if (!self.puzzleEngine)NSLog(@"puzzle engin PROBLEM");
    
    
    self.puzzleEngine.numberOfHiddenObjects = 8;
    self.puzzleEngine.numberOfMusicFiles = 15;
    self.puzzleEngine.hostView= self.view;
    self.puzzleEngine.puzzleTimer = self.puzzleTimer;
    self.puzzleEngine.puzzleTime = 90.0;
    self.puzzleEngine.delegate = self;
    [self.puzzleEngine startEngine];
	
	[self puzzleInstructionImageTransformScale:0.1];
	
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		[self puzzleInstructionImageTransformScale:1.3];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
			[self puzzleInstructionImageTransformScale:1.0];
		} completion:nil];
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.trackedViewName = @"Dinner Puzzle";

    self.physicsUtility = [[PPPhysicsUtility alloc] init];
    self.physicsUtility.effectedBody=self.PZL07_miaow02a;
    [self.physicsUtility startPhysicsEngine];
    //set up mr. miaow
    self.PZL07_miaow01.hidden = NO;
    self.PZL07_miaow02b.hidden = YES;
    self.PZL07_miaow02a.hidden = YES;
    UITapGestureRecognizer * miaotap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(miaowTapped:)];
    self.PZL07_miaow01.userInteractionEnabled = YES;
    [self.PZL07_miaow01 addGestureRecognizer:miaotap];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MrMiaow.mp3", [[NSBundle mainBundle] resourcePath]]];
    [self.miaoPlayer prepareToPlay];
	
	NSError *error;
    self.miaoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    //[self setupChipmunk];


	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPZL07_BG02:nil];
    [self setPZL07_01a:nil];
    [self setPZL07_01b:nil];
    [self setPZL07_01c:nil];
    [self setPZL07_02a:nil];
    [self setPZL07_02b:nil];
    [self setPZL07_02c:nil];
    [self setPZL07_03a:nil];
    [self setPZL07_03b:nil];
    [self setPZL07_03c:nil];
    [self setPZL07_04c:nil];
    [self setPZL07_04b:nil];
    [self setPZL07_04a:nil];
    [self setPZL07_05c:nil];
    [self setPZL07_05b:nil];
    [self setPZL07_05a:nil];
    [self setPZL07_06c:nil];
    [self setPZL07_06b:nil];
    [self setPZL07_06a:nil];
    [self setPZL07_07c:nil];
    [self setPZL07_07b:nil];
    [self setPZL07_07a:nil];
    [self setPZL07_08c:nil];
    [self setPZL07_08b:nil];
    [self setPZL07_08a:nil];
    [self setPZL07_09c:nil];
    [self setPZL07_09b:nil];
    [self setPZL07_09a:nil];
    [self setPZL07_10c:nil];
    [self setPZL07_10b:nil];
    [self setPZL07_10a:nil];
    [self setPZL07_11c:nil];
    [self setPZL07_11b:nil];
    [self setPZL07_11a:nil];
    [self setPZL07_12c:nil];
    [self setPZL07_12b:nil];
    [self setPZL07_12a:nil];
    [self setPZL07_13c:nil];
    [self setPZL07_13b:nil];
    [self setPZL07_13a:nil];
    [self setPZL07_14c:nil];
    [self setPZL07_14b:nil];
    [self setPZL07_14a:nil];
    [self setPZL07_15c:nil];
    [self setPZL07_15b:nil];
    [self setPZL07_15a:nil];
    [self setPZL07_18c:nil];
    [self setPZL07_18b:nil];
    [self setPZL07_18a:nil];
    [self setPZL07_19c:nil];
    [self setPZL07_19b:nil];
    [self setPZL07_19a:nil];
    [self setPZL07_miaow01:nil];
    [self setPZL07_miaow02b:nil];

    [self setPZL07_BG01:nil];
    [self setPZL07_17c:nil];
    [self setPZL07_17b:nil];
    [self setPZL07_17a:nil];

    [self setPuzzleTimer:nil];

    [self setHiddenImage:nil];
	[self setPZL_Instruction_Play:nil];
	[self setPZL_Instruction_Skip:nil];
    [super viewDidUnload];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return YES;
	return NO;
}

@end
