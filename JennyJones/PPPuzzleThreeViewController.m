//
//  PPPuzzleThreeViewController.m
//  JennyJones
//
//  Created by Corey Manders on 3/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPuzzleThreeViewController.h"
#import "PPPuzzleEngine.h"
#import "PPPhysicsUtility.h"
#import <AVFoundation/AVFoundation.h>

@interface PPPuzzleThreeViewController ()<PPPuzzleEngineDelegate,UIScrollViewDelegate>

@property (strong) PPPuzzleEngine * puzzleEngine;
@property (strong) AVAudioPlayer * miaoPlayer;
@property (strong) PPPhysicsUtility * physicsUtility;
@property (strong) NSArray * squareArray;
@property (strong) NSArray * roundArray;
@property (strong) NSArray * colorArray;
@property float lastX;
@property PPWatchView *puzzleTimer;

@property (weak, nonatomic) IBOutlet UIImageView *PZL_DimBackground;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Play;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Skip;

@end

@implementation PPPuzzleThreeViewController
@synthesize PZL08_25a;
@synthesize PZL08_25b;
@synthesize PZL08_26b;
@synthesize PZL08_26a;
@synthesize PZL08_27c;
@synthesize PZL08_27b;
@synthesize PZL08_27a;
@synthesize PZL08_28c;
@synthesize PZL08_28b;
@synthesize PZL08_28a;
@synthesize PZL08_Miaow01;
@synthesize PZL08_Miaow02b;
@synthesize PZL08_Miaow02a;
@synthesize PZL08_14a;
@synthesize puzzleTimer;
@synthesize PZL08_24c;
@synthesize PZL08_24b;
@synthesize PZL08_24a;
@synthesize PZL08_25c;
@synthesize PZL08_26c;
@synthesize PZL08_BG;
@synthesize PZL08_Reveal;
@synthesize PZL08_01a;
@synthesize PZL08_01b;
@synthesize PZL08_01c;
@synthesize PZL08_02c;
@synthesize PZL08_02b;
@synthesize PZL08_02a;
@synthesize PZL08_03c;
@synthesize PZL08_03b;
@synthesize PZL08_03a;
@synthesize PZL08_04c;
@synthesize PZL08_04b;
@synthesize PZL08_04a;
@synthesize PZL08_05c;
@synthesize PZL08_05b;
@synthesize PZL08_05a;
@synthesize PZL08_06c;
@synthesize PZL08_06b;
@synthesize PZL08_06a;
@synthesize PZL08_07c;
@synthesize PZL08_07b;
@synthesize PZL08_07a;
@synthesize PZL08_08c;
@synthesize PZL08_08b;
@synthesize PZL08_08a;
@synthesize PZL08_09c;
@synthesize PZL08_09b;
@synthesize PZL08_09a;
@synthesize PZL08_10c;
@synthesize PZL08_10b;
@synthesize PZL08_10a;
@synthesize PZL08_11c;
@synthesize PZL08_11b;
@synthesize PZL08_11a;
@synthesize PZL08_12c;
@synthesize PZL08_12b;
@synthesize PZL08_12a;
@synthesize PZL08_13c;
@synthesize PZL08_13b;
@synthesize PZL08_13a;
@synthesize PZL08_14c;
@synthesize PZL08_14b;
@synthesize PZL08_15a;
@synthesize PZL08_15c;
@synthesize PZL08_15b;
@synthesize PZL08_16c;
@synthesize PZL08_16b;
@synthesize PZL08_16a;
@synthesize PZL08_17c;
@synthesize PZL08_17b;
@synthesize PZL08_17a;
@synthesize PZL08_18c;
@synthesize PZL08_18b;
@synthesize PZL08_18a;
@synthesize PZL08_19c;
@synthesize PZL08_19b;
@synthesize PZL08_19a;
@synthesize PZL08_20c;
@synthesize PZL08_20b;
@synthesize PZL08_20a;
@synthesize PZL08_21c;
@synthesize PZL08_21b;
@synthesize PZL08_21a;
@synthesize PZL08_22c;
@synthesize PZL08_22b;
@synthesize PZL08_22a;
@synthesize PZL08_23a;
@synthesize PZL08_23c;
@synthesize PZL08_23b;
@synthesize scrollView;
@synthesize puzzleEngine = _puzzleEngine;
@synthesize miaoPlayer = _miaoPlayer;
@synthesize physicsUtility = _physicsUtility;
@synthesize colorArray = _colorArray;
@synthesize squareArray = _squareArray;
@synthesize roundArray = _roundArray;
@synthesize lastX = _lastX;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)puzzleInstructionTapped:(UITapGestureRecognizer *)sender
{
	self.PZL_Instruction.userInteractionEnabled = NO;
	self.PZL_DimBackground.hidden = YES;
	[UIView animateWithDuration:0.5 animations:^{
		[self puzzleInstructionImageTransformScale:0.0];
	}];
	
	self.scrollView.scrollEnabled = YES;
	[self.puzzleEngine startTimer];
}

- (IBAction)puzzleInstructionSkipped:(UITapGestureRecognizer *)sender {
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
    self.scrollView.delegate = self;
    self.puzzleTimer = [[PPWatchView alloc] initWatchView];
    [self.view addSubview:self.puzzleTimer];
	
	self.PZL_DimBackground.alpha = 0.45;
	
	self.scrollView.scrollEnabled = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.trackedViewName = @"Garden Puzzle";
	
    self.scrollView.contentSize = CGSizeMake(2048, 768);
    self.scrollView.bounces = NO;
	self.scrollView.showsHorizontalScrollIndicator = NO;
    self.roundArray= [NSArray arrayWithObjects:self.PZL08_01a, self.PZL08_02a, self.PZL08_03a,
                      self.PZL08_04a, self.PZL08_05a, self.PZL08_06a, self.PZL08_07a,
                      self.PZL08_09a, self.PZL08_10a, self.PZL08_11a, self.PZL08_12a,
                      self.PZL08_13a, self.PZL08_14a, self.PZL08_15a, self.PZL08_16a,
                      self.PZL08_17a, self.PZL08_18a, self.PZL08_19a, self.PZL08_20a,
                      self.PZL08_21a, self.PZL08_22a, self.PZL08_23a, self.PZL08_24a,
                      self.PZL08_25a, self.PZL08_26a, self.PZL08_27a, self.PZL08_28a,
                      nil];
    self.colorArray = [NSArray arrayWithObjects:self.PZL08_01b, self.PZL08_02b, self.PZL08_03b,
                       self.PZL08_04b, self.PZL08_05b, self.PZL08_06b, self.PZL08_07b,
                       self.PZL08_09b, self.PZL08_10b, self.PZL08_11b, self.PZL08_12b,
                       self.PZL08_13b, self.PZL08_14b, self.PZL08_15b, self.PZL08_16b,
                       self.PZL08_17b, self.PZL08_18b, self.PZL08_19b, self.PZL08_20b,
                       self.PZL08_21b, self.PZL08_22b, self.PZL08_23b, self.PZL08_24b,
                       self.PZL08_25b, self.PZL08_26b, self.PZL08_27b, self.PZL08_28b,
                       nil];
    
    self.squareArray = [NSArray arrayWithObjects:self.PZL08_01c, self.PZL08_02c, self.PZL08_03c,
                        self.PZL08_04c, self.PZL08_05c, self.PZL08_06c, self.PZL08_07c,
                        self.PZL08_09c, self.PZL08_10c, self.PZL08_11c, self.PZL08_12c,
                        self.PZL08_13c, self.PZL08_14c, self.PZL08_15c, self.PZL08_16c,
                        self.PZL08_17c, self.PZL08_18c, self.PZL08_19c, self.PZL08_20c,
                        self.PZL08_21c, self.PZL08_22c, self.PZL08_23c, self.PZL08_24c,
                        self.PZL08_25c, self.PZL08_26c, self.PZL08_27c, self.PZL08_28c,
                        nil];
    
    for (UIView * temp in self.roundArray) temp.hidden=YES;
    for (UIView * temp in self.colorArray) temp.hidden=YES;
    for (UIView * temp in self.squareArray) temp.hidden=YES;
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.PZL08_Miaow01.hidden = NO;
    self.PZL08_Miaow02a.hidden = YES;
    self.PZL08_Miaow02b.hidden = YES;
	self.lastX = -INFINITY;
    //set up the miao sound
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MrMiaow.mp3", [[NSBundle mainBundle] resourcePath]]];
    [self.miaoPlayer prepareToPlay];
    
	NSError *error;
    self.miaoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.puzzleEngine = [[PPPuzzleEngine alloc] initWithBWObjects:self.roundArray
                         
                                                            color:self.colorArray
                                                         bwSquare:self.squareArray
                                                       backgound1:self.PZL08_BG background2:nil background3:nil reveal1:self.PZL08_Reveal reveal2:nil reveal3:nil];
    
    self.navigationController.navigationBar.hidden = YES;
    self.puzzleEngine.numberOfHiddenObjects = 12;
    self.puzzleEngine.numberOfMusicFiles = 15;
    self.puzzleEngine.hostView= self.view;
    self.puzzleEngine.puzzleTimer = self.puzzleTimer;
    self.puzzleEngine.puzzleTime = 90.0;
    self.puzzleEngine.delegate = self;
    [self.puzzleEngine startEngine];
    
    //set up the physicsEngine
    self.physicsUtility = [[PPPhysicsUtility alloc] init];
    self.physicsUtility.hostview = self.view;
    self.physicsUtility.effectedBody = self.PZL08_Miaow02a;
    [self.physicsUtility startPhysicsEngine];
    UITapGestureRecognizer * miaotap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(miaowTapped:)];
    self.PZL08_Miaow01.userInteractionEnabled = YES;
    [self.PZL08_Miaow01 addGestureRecognizer:miaotap];
	
	[self puzzleInstructionImageTransformScale:0.1];
	
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		[self puzzleInstructionImageTransformScale:1.3];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
			[self puzzleInstructionImageTransformScale:1.0];
		} completion:nil];
	}];
}

-(void) resetMiaow
{
    [self.physicsUtility resetEffectedBody];
    self.PZL08_Miaow01.hidden = NO;
    self.PZL08_Miaow02a.hidden = YES;
    self.PZL08_Miaow02b.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollViewLocal
{
	if (self.lastX < -100000){
		self.lastX=scrollViewLocal.contentOffset.x;
		return;
	}
	else{
		float deltaX = self.lastX-scrollViewLocal.contentOffset.x;
		self.lastX = scrollViewLocal.contentOffset.x;
	
		CGPoint emmiterPoint = self.puzzleEngine.emitter2.emitterPosition;
		emmiterPoint.x = emmiterPoint.x + deltaX;
		self.puzzleEngine.emitter2.emitterPosition = emmiterPoint;
	}
}

- (IBAction)miaowTapped:(UITapGestureRecognizer *)sender {
    UIView * hintObject=[self.puzzleEngine giveHintUsingEmitterWithContentOffset:[self.scrollView contentOffset].x];

	[self.scrollView scrollRectToVisible:hintObject.frame animated:YES];
    self.PZL08_Miaow01.hidden = YES;
    self.PZL08_Miaow02a.hidden = NO;
    self.PZL08_Miaow02b.hidden = NO;

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.miaoPlayer play];
    [self.physicsUtility applyForceToEffectedBody];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetMiaow) userInfo:nil repeats:NO];
}

-(void) puzzleCompleted:(BOOL)complete
{
    self.PZL08_Miaow02a.hidden = YES;
    self.PZL08_Miaow02b.hidden = YES;
    self.PZL08_Miaow01.hidden = YES;
    
    NSNumber * previousTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two time"];
    if (!previousTime)
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle three time"];
    else {
        if (self.puzzleTimer.timeTaken < [previousTime floatValue])
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle three time"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"puzzle three done"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.puzzleTimer.alpha = 0.0;
    }completion:^(BOOL finished){
        [self dismissModalViewControllerAnimated:NO];
    }];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPZL08_BG:nil];
    [self setPZL08_Reveal:nil];
    [self setPZL08_01a:nil];
    [self setPZL08_01b:nil];
    [self setPZL08_01c:nil];
    [self setPZL08_02c:nil];
    [self setPZL08_02b:nil];
    [self setPZL08_02a:nil];
    [self setPZL08_03c:nil];
    [self setPZL08_03b:nil];
    [self setPZL08_03a:nil];
    [self setPZL08_04c:nil];
    [self setPZL08_04b:nil];
    [self setPZL08_04a:nil];
    [self setPZL08_05c:nil];
    [self setPZL08_05b:nil];
    [self setPZL08_05a:nil];
    [self setPZL08_06c:nil];
    [self setPZL08_06b:nil];
    [self setPZL08_06a:nil];
    [self setPZL08_07c:nil];
    [self setPZL08_07b:nil];
    [self setPZL08_07a:nil];
    [self setPZL08_08c:nil];
    [self setPZL08_08b:nil];
    [self setPZL08_08a:nil];
    [self setPZL08_09c:nil];
    [self setPZL08_09b:nil];
    [self setPZL08_09a:nil];
    [self setPZL08_10c:nil];
    [self setPZL08_10b:nil];
    [self setPZL08_10a:nil];
    [self setPZL08_11c:nil];
    [self setPZL08_11b:nil];
    [self setPZL08_11a:nil];
    [self setPZL08_12c:nil];
    [self setPZL08_12b:nil];
    [self setPZL08_12a:nil];
    [self setPZL08_13c:nil];
    [self setPZL08_13b:nil];
    [self setPZL08_13a:nil];
    [self setPZL08_14c:nil];
    [self setPZL08_14b:nil];
    [self setPZL08_15a:nil];
    [self setPZL08_15c:nil];
    [self setPZL08_15b:nil];
    [self setPZL08_15a:nil];
    [self setPZL08_16c:nil];
    [self setPZL08_16b:nil];
    [self setPZL08_16a:nil];
    [self setPZL08_17c:nil];
    [self setPZL08_17b:nil];
    [self setPZL08_17a:nil];
    [self setPZL08_18c:nil];
    [self setPZL08_18b:nil];
    [self setPZL08_18a:nil];
    [self setPZL08_19c:nil];
    [self setPZL08_19b:nil];
    [self setPZL08_19a:nil];
    [self setPZL08_20c:nil];
    [self setPZL08_20b:nil];
    [self setPZL08_20a:nil];
    [self setPZL08_21c:nil];
    [self setPZL08_21b:nil];
    [self setPZL08_21a:nil];
    [self setPZL08_22c:nil];
    [self setPZL08_22b:nil];
    [self setPZL08_22a:nil];
    [self setPZL08_23c:nil];
    [self setPZL08_23b:nil];
    [self setPZL08_23b:nil];
    [self setPZL08_24c:nil];
    [self setPZL08_24b:nil];
    [self setPZL08_24a:nil];
    [self setPZL08_25c:nil];
    [self setPZL08_26c:nil];
    [self setPZL08_25a:nil];
    [self setPZL08_26c:nil];
    [self setPZL08_26b:nil];
    [self setPZL08_26a:nil];
    [self setPZL08_27c:nil];
    [self setPZL08_27b:nil];
    [self setPZL08_27a:nil];
    [self setPZL08_28c:nil];
    [self setPZL08_28b:nil];
    [self setPZL08_28a:nil];
    [self setPZL08_Miaow01:nil];
    [self setPZL08_Miaow02b:nil];
    [self setPZL08_Miaow02a:nil];
    [self setPZL08_14a:nil];
    [self setPuzzleTimer:nil];
	[self setPZL_Instruction_Play:nil];
	[self setPZL_Instruction_Skip:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        return YES;
	return NO;
}

@end