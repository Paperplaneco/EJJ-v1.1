//
//  PPPuzzle10ViewController.m
//  JennyJones
//
//  Created by Corey on 27/9/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPuzzle10ViewController.h"
#import "PPPuzzleEngine.h"
#import "PPPhysicsUtility.h"
#import "PPWatchView.h"

@interface PPPuzzle10ViewController ()<UIScrollViewDelegate, PPPuzzleEngineDelegate>
@property PPWatchView *puzzleTimer;
@property (strong) AVAudioPlayer * miaoPlayer;
@property UIImageView * replicatedBGImage3;
@property UIImageView * replicatedBGImage1;
@property PPPuzzleEngine * puzzleEngine;
@property (strong) PPPhysicsUtility * physicsUtility;
@property float fullwidth;
@property float lastX;
@property NSMutableArray * additionalAs;
@property NSMutableArray * additionalBs;
@property NSMutableArray * additionalCs;
@property (strong) NSMutableArray *additionalImages;
@property (strong) NSMutableArray * additionalReveal;



@property (weak, nonatomic) IBOutlet UIImageView *PZL_DimBackground;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Play;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Instruction_Skip;

@end

@implementation PPPuzzle10ViewController

@synthesize replicatedBGImage3 = _replicatedBGImage3;
@synthesize replicatedBGImage1 = _replicatedBGImage1;
@synthesize fullwidth = _fullwidth;
@synthesize puzzleEngine = _puzzleEngine;
@synthesize physicsUtility = _physicsUtility;
@synthesize miaoPlayer = _miaoPlayer;
@synthesize lastX = _lastX;
@synthesize additionalAs = _additionalAs;
@synthesize additionalBs = _additionalBs;
@synthesize additionalCs = _additionalCs;

@synthesize  PZL09_Jenny01_2 = _PZL09_Jenny01_2;
@synthesize   PZL09_Miaow01_2 = _PZL09_Miaow01_2;
@synthesize   PZL09_Miao01_head_2 = _PZL09_Miao01_head_2;
@synthesize  PZL09_Miao02_2 = _PZL09_Miao02_2;
@synthesize additionalImages = _additionalImages;
@synthesize additionalReveal = _additionalReveal;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.trackedViewName = @"Funfair Puzzle";
	
    //set up the scroller
    
    self.scroller.delegate = self;
    self.scroller.decelerationRate = UIScrollViewDecelerationRateFast;

    //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    _puzzleTimer = [[PPWatchView alloc] initWatchView];
    [self.view addSubview:_puzzleTimer];
    
    //set-up the additional arrays
    self.additionalAs = [[NSMutableArray alloc] init];
    self.additionalBs = [[NSMutableArray alloc] init];
    self.additionalCs = [[NSMutableArray alloc] init];
    self.additionalImages = [[NSMutableArray alloc] init];
    self.additionalReveal = [[NSMutableArray alloc] init];
    self.puzzleEngine.hasReplicatedObjects = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
    if (scrollView.contentOffset.x >self.replicatedBGImage1.frame.origin.x-10 ) {
        self.scroller.contentOffset = CGPointMake(self.scroller.contentOffset.x-self.fullwidth, 0.0);
     
    }
    else if (scrollView.contentOffset.x <self.background1.frame.origin.x-10 )
        self.scroller.contentOffset = CGPointMake(self.scroller.contentOffset.x+self.fullwidth, 0.0);
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    if (scrollView.contentOffset.x >self.replicatedBGImage1.frame.origin.x-10 ) {
        self.scroller.contentOffset = CGPointMake(self.scroller.contentOffset.x-self.fullwidth, 0.0);
     
    }
    else if (scrollView.contentOffset.x <self.background1.frame.origin.x-10 )
        self.scroller.contentOffset = CGPointMake(self.scroller.contentOffset.x+self.fullwidth, 0.0);
    
	
	if (self.lastX < -100000){
		self.lastX=scrollView.contentOffset.x;
		return;
	}
	else{
		float deltaX = self.lastX-scrollView.contentOffset.x;
		self.lastX = scrollView.contentOffset.x;
		
		CGPoint emmiterPoint = self.puzzleEngine.emitter2.emitterPosition;
		emmiterPoint.x = emmiterPoint.x + deltaX;
		self.puzzleEngine.emitter2.emitterPosition = emmiterPoint;
	}
}

-(void)puzzleCompleted:(BOOL)complete
{
    
    NSNumber * previousTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle ten time"];
    if (!previousTime)
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle ten time"];
    else {
        if (self.puzzleTimer.timeTaken < [previousTime floatValue])
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:self.puzzleTimer.timeTaken] forKey:@"puzzle ten time"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"puzzle ten done"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissModalViewControllerAnimated:NO];
    
}

- (IBAction)puzzleInstructionTapped:(UITapGestureRecognizer *)sender
{
	self.PZL_Instruction.userInteractionEnabled = NO;
	self.PZL_DimBackground.hidden = YES;
	[UIView animateWithDuration:0.5 animations:^{
		[self puzzleInstructionImageTransformScale:0.0];
	}];
	
	self.scroller.scrollEnabled = YES;
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

- (IBAction)miaowTapped:(UITapGestureRecognizer *)sender
{
	UIView *hintObject = [self.puzzleEngine giveHintUsingEmitterWithContentOffset:[self.scroller contentOffset].x];
	
	[self.scroller scrollRectToVisible:hintObject.frame animated:YES];
	self.PZL09_Miao02.center = self.PZL09_Miao01_head.center;
	self.PZL09_Miao02.hidden = NO;
	self.PZL09_Miao01_head.hidden = YES;

	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.miaoPlayer play];
	[self.physicsUtility applyForceToEffectedBody];
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetMiaow) userInfo:nil repeats:NO];
}

-(void) temporaryTapCallback:(UITapGestureRecognizer *)sender
{
    NSLog(@"duplicate object tapped");
}

- (void) resetMiaow
{
	[self.physicsUtility resetEffectedBody];
	self.PZL09_Miao02.hidden = YES;
	self.PZL09_Miao01_head.hidden = NO;
}

-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.scroller.scrollEnabled = NO;
	
    self.navigationController.toolbarHidden = YES;

    //precisely align the background images.

    self.imageSection1.hidden = YES;
    self.imageSection2.hidden = YES;
    self.imageSection3.hidden = YES;
    if (!self.imageSection1)NSLog(@"No image section1");
    if (!self.imageSection2)NSLog(@"No image section2");
    if (!self.imageSection3)NSLog(@"No image section3");
    float width1 = self.background1.frame.size.width;
    float width2 = self.background2.frame.size.width;
    float width3 = self.background3.frame.size.width;

    self.fullwidth = width1+width2+width3;


    // add an additional image background on the left side
    self.puzzleView.frame = CGRectMake(0.0, 0.0, self.fullwidth+width3+width1, self.background3.frame.size.height);
    
    //shift the background images to compensate
    CGRect aligner = self.background1.frame;
    aligner.origin.x = self.background3.frame.size.width; // offset the background by the width of image 3
    self.background1.frame =aligner;
    self.imageSection1.frame = aligner;
    
    aligner = self.background2.frame;
    aligner.origin.x = self.background1.frame.origin.x+self.background1.frame.size.width;
    self.background2.frame = aligner;
    self.imageSection2.frame = aligner;
    
    aligner = self.background3.frame;
    aligner.origin.x = self.background2.frame.origin.x+self.background2.frame.size.width;
    self.background3.frame = aligner;
    self.imageSection3.frame = aligner;
    
    //add the replicated image
    //self.replicatedBGImage3= [[UIImageView alloc] initWithImage:self.background3.image];
    //if (!self.replicatedBGImage3) NSLog(@"NO BACKGROUND IMAGE");
    //self.replicatedBGImage3.frame = CGRectMake(0.0, 0.0, self.background3.frame.size.width, self.background3.frame.size.height);
    //self.replicatedBGImage3.contentMode =self.background3.contentMode;
    //[self.puzzleView addSubview:self.replicatedBGImage3];
    //self.replicatedBGImage3.hidden = YES;
    //take care of the reveal image
   // UIImageView * additionalReveal1 = [[UIImageView alloc] initWithImage:self.imageSection3.image];
   // additionalReveal1.frame = self.replicatedBGImage3.frame;
   // additionalReveal1.contentMode = self.replicatedBGImage3.contentMode;
  //  additionalReveal1.hidden = YES;
   // [self.puzzleView addSubview:additionalReveal1];
   // [self.additionalImages addObject:self.replicatedBGImage3];
   // [self.additionalReveal addObject:additionalReveal1];
    

    //add the replicated image
    self.replicatedBGImage1= [[UIImageView alloc] initWithImage:self.background1.image];
    if (!self.replicatedBGImage1) NSLog(@"NO BACKGROUND IMAGE --2---");
    self.replicatedBGImage1.frame = CGRectMake(self.background3.frame.origin.x+self.background3.frame.size.width, 0.0, self.background1.frame.size.width, self.background1.frame.size.height);
    self.replicatedBGImage1.contentMode =self.background3.contentMode;
   
    self.replicatedBGImage1.hidden = NO;
    //take care of the reveal image
  
    UIImageView * additionalReveal2 = [[UIImageView alloc] initWithImage:self.imageSection1.image];
    if (!additionalReveal2)NSLog(@"ADditional reveial DID NOT LOAD");
    additionalReveal2.frame = self.replicatedBGImage1.frame;
    additionalReveal2.contentMode = self.replicatedBGImage1.contentMode;
    additionalReveal2.hidden = NO;
    additionalReveal2.alpha = 0.0;
    [self.puzzleView addSubview:additionalReveal2];
    [self.puzzleView addSubview:self.replicatedBGImage1];
    [self.additionalImages addObject:self.replicatedBGImage1];
    [self.additionalReveal addObject:additionalReveal2];
    
    
    
    //shift the objects associated with the view 
    for (UIImageView * view in self.Bimages){
        CGRect newFrame = view.frame;
        newFrame.origin.x+= self.background3.frame.size.width;
        view.frame = newFrame;
        if ( CGRectContainsPoint(self.background3.frame, view.center) )
        {
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x-self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            temp.hidden = view.hidden;

            
            [self.puzzleView addSubview:temp];
            [self.additionalBs addObject:temp];
         
        }
    }
    for (UIImageView * view in self.Aimages){
        
        CGRect newFrame = view.frame;
        newFrame.origin.x+= self.background3.frame.size.width;
        view.frame= newFrame;
        if ( CGRectContainsPoint(self.background3.frame, view.center) )
        {
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            temp.hidden = view.hidden;
            temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x-self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

            [self.puzzleView addSubview:temp];
            [self.additionalAs addObject:temp];
            
        }
    }
    for (UIImageView * view in self.Cimages){
        
        CGRect newFrame = view.frame;
        newFrame.origin.x+= self.background3.image.size.width;
        view.frame = newFrame;
        if ( CGRectContainsPoint(self.background3.frame, view.center) )
        {
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            // add a tap recognizer incase it gets tapped

            temp.hidden = view.hidden;
            temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x-self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            [self.puzzleView addSubview:temp];
            [self.additionalCs addObject:temp];
            
        }
    }
    
    

    
    //add in the object for the frame
    for (UIImageView * view in self.Bimages){
        if ( CGRectContainsPoint(self.background1.frame, view.center) ){
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            temp.hidden = view.hidden;
            temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x+self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

            [self.puzzleView addSubview:temp];
            [self.additionalBs addObject:temp];
        }
    }
    for (UIImageView * view in self.Aimages){
        if ( CGRectContainsPoint(self.background1.frame, view.center) ){
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            temp.hidden = view.hidden;
           temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x+self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

            [self.puzzleView addSubview:temp];
            [self.additionalAs addObject:temp];
        }
    }
    for (UIImageView * view in self.Cimages){
        if ( CGRectContainsPoint(self.background1.frame, view.center) ){
            UIImageView *temp = [[UIImageView alloc] initWithImage:view.image];
            temp.hidden = view.hidden;
            temp.contentMode = view.contentMode;
            temp.frame = CGRectMake(view.frame.origin.x+self.fullwidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

            [self.puzzleView addSubview:temp];
            [self.additionalCs addObject:temp];
        }
    }
    
    

    
    self.puzzleView.frame = CGRectMake(0.0, 0.0, self.fullwidth+self.background1.frame.size.width+self.background1.frame.size.width, 768.0);
    
    //self.scroller.frame = self.view.frame
    self.scroller.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
    self.scroller.contentSize = self.puzzleView.frame.size;

    self.scroller.decelerationRate = UIScrollViewDecelerationRateFast;
    self.scroller.contentOffset = CGPointMake(self.background2.center.x, 0.0);
	
    self.PZL_Instruction.center = CGPointMake(self.background2.frame.origin.x + 962, 384);
	self.PZL_Instruction_Play.center = CGPointMake(self.background2.frame.origin.x + 1096, 490);
	self.PZL_Instruction_Skip.center = CGPointMake(self.background2.frame.origin.x + 850, 490);
	self.PZL_DimBackground.center = CGPointMake(self.background2.frame.origin.x + 962, 384);
	
	self.PZL_DimBackground.alpha = 0.45;
	
	[self puzzleInstructionImageTransformScale:0.1];
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	//set up the miao sound
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MrMiaow.mp3", [[NSBundle mainBundle] resourcePath]]];
    [self.miaoPlayer prepareToPlay];
    
	NSError *error;
    self.miaoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	
    self.puzzleEngine = [[PPPuzzleEngine alloc] initWithBWObjects:
                         [NSArray arrayWithObjects:self.PZL09_01a, self.PZL09_02a, self.PZL09_03a,
                          self.PZL09_04a, self.PZL09_05a, self.PZL09_06a, self.PZL09_07a,
                          self.PZL09_08a, self.PZL09_11a, self.PZL09_12a, self.PZL09_13a,
                          self.PZL09_14a, self.PZL09_15a, self.PZL09_17a, self.PZL09_19a,
                          self.PZL09_14a, self.PZL09_15a, self.PZL09_17a, self.PZL09_18a,
                          self.PZL09_20a, self.PZL09_22a, self.PZL09_23a, self.PZL09_24a,
                          self.PZL09_25a, self.PZL09_27a, self.PZL09_28a, self.PZL09_29a,
                          self.PZL09_30a, self.PZL09_31a, self.PZL09_32a, self.PZL09_33a, self.PZL09_21a,
                          nil]
                        
                        color:[NSArray arrayWithObjects:self.PZL09_01b, self.PZL09_02b, self.PZL09_03b,
                            self.PZL09_04b, self.PZL09_05b, self.PZL09_06b, self.PZL09_07b,
                            self.PZL09_08b, self.PZL09_11b, self.PZL09_12b, self.PZL09_13b,
                            self.PZL09_14b, self.PZL09_15b, self.PZL09_17b, self.PZL09_19b,
                            self.PZL09_14b, self.PZL09_15b, self.PZL09_17b, self.PZL09_18b,
                            self.PZL09_20b, self.PZL09_22b, self.PZL09_23b, self.PZL09_24b,
                            self.PZL09_25b, self.PZL09_27b, self.PZL09_28b, self.PZL09_29b,
                            self.PZL09_30b, self.PZL09_31b, self.PZL09_32b, self.PZL09_33b, self.PZL09_21b,
							   nil]

                         
                        bwSquare:[NSArray arrayWithObjects:self.PZL09_01c, self.PZL09_02c, self.PZL09_03c,
                            self.PZL09_04c, self.PZL09_05c, self.PZL09_06c, self.PZL09_07c,
                            self.PZL09_08c, self.PZL09_11c, self.PZL09_12c, self.PZL09_13c,
                            self.PZL09_14c, self.PZL09_15c, self.PZL09_17c, self.PZL09_19c,
                            self.PZL09_14c, self.PZL09_15c, self.PZL09_17c, self.PZL09_18c,
                            self.PZL09_20c, self.PZL09_22c, self.PZL09_23c, self.PZL09_24c,
                            self.PZL09_25c, self.PZL09_27c, self.PZL09_28c, self.PZL09_29c,
                            self.PZL09_30c, self.PZL09_31c, self.PZL09_32c, self.PZL09_33c, self.PZL09_21c,
                                  nil]
                         
                        backgound1:self.background1 background2:self.background2 background3:self.background3 reveal1:self.imageSection1 reveal2:self.imageSection2 reveal3:self.imageSection3];
  
    self.navigationController.navigationBar.hidden = YES;
    self.puzzleEngine.numberOfHiddenObjects = 20;
    self.puzzleEngine.numberOfMusicFiles = 20;
    self.puzzleEngine.hostView= self.view;
    self.puzzleEngine.puzzleTimer = self.puzzleTimer;
    self.puzzleEngine.puzzleTime = 180.0;
    self.puzzleEngine.delegate = self;
    
    //tell the puzzle engine about the replicated objects
    self.puzzleEngine.hasReplicatedObjects = YES;
    self.puzzleEngine.replicatedObjectsA = [NSArray arrayWithArray:self.additionalAs];
    self.puzzleEngine.replicatedObjectsB = [NSArray arrayWithArray:self.additionalBs];
    self.puzzleEngine.replicatedObjectsC = [NSArray arrayWithArray:self.additionalCs];
    self.puzzleEngine.additionalImages = [NSArray arrayWithArray:self.additionalImages];
    self.puzzleEngine.additionalReveal = [NSArray arrayWithArray:self.additionalReveal];
    
    [self.puzzleEngine startEngine];

 
	self.PZL09_Jenny01.hidden = NO;
	self.PZL09_Miaow01.hidden = NO;
	self.PZL09_Miao02.hidden = YES;
	self.PZL09_Miao01_head.hidden = NO;
	
	self.PZL09_Jenny01.center = CGPointMake(self.background1.frame.origin.x + 1300, 630);
	self.PZL09_Miaow01.center = CGPointMake(self.PZL09_Jenny01.center.x - 18, self.PZL09_Jenny01.center.y - 55);
	self.PZL09_Miao01_head.center = CGPointMake(self.PZL09_Miaow01.center.x - 5, self.PZL09_Miaow01.center.y - 20);
	self.PZL09_Miao02.center = CGPointMake(self.PZL09_Miaow01.center.x - 5, self.PZL09_Miaow01.center.y - 20);
    
        //create Jenny's doppleganger
    self.PZL09_Jenny01_2 = [[UIImageView alloc] initWithImage:self.PZL09_Jenny01.image];
    CGPoint j2 = self.PZL09_Jenny01.center;
    j2.x +=self.fullwidth;
    self.PZL09_Jenny01_2.center = j2;
    self.PZL09_Jenny01_2.contentMode =  self.PZL09_Jenny01.contentMode;
    [self.puzzleView addSubview:self.PZL09_Jenny01_2];
    
    self.PZL09_Miaow01_2 = [[UIImageView alloc] initWithImage:self.PZL09_Miaow01.image];
    self.PZL09_Miaow01_2.frame = self.PZL09_Miaow01.frame;
    j2 = self.PZL09_Miaow01.center;
    j2.x +=self.fullwidth;
    self.PZL09_Miaow01_2.center = j2;
    self.PZL09_Miaow01_2.contentMode = self.PZL09_Miaow01.contentMode;
    [self.puzzleView addSubview:self.PZL09_Miaow01_2];
    
    self.PZL09_Miao01_head_2 = [[UIImageView alloc] initWithImage:self.PZL09_Miao01_head.image];
    self.PZL09_Miao01_head_2.frame = self.PZL09_Miao01_head.frame;
    j2 = self.PZL09_Miao01_head.center;
    j2.x +=self.fullwidth;
    self.PZL09_Miao01_head_2.center = j2;
    self.PZL09_Miao01_head.contentMode = self.PZL09_Miao01_head_2.contentMode;
    [self.puzzleView addSubview:self.PZL09_Miao01_head_2];


    
	//set up the physicsEngine
    self.physicsUtility = [[PPPhysicsUtility alloc] init];
    self.physicsUtility.hostview = self.scroller;
    self.physicsUtility.effectedBody = self.PZL09_Miao02;
    [self.physicsUtility startPhysicsEngine];
	
	self.lastX = -INFINITY;
	
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		[self puzzleInstructionImageTransformScale:1.3];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
			[self puzzleInstructionImageTransformScale:1.0];
		} completion:nil];
	}];
 
}

- (void)viewDidUnload {
    [self setPZL09_01b:nil];
    [self setPZL09_02b:nil];
    [self setPZL09_03b:nil];
    [self setPZL09_04b:nil];
    [self setPZL09_05b:nil];
    [self setPZL09_06b:nil];
    [self setPZL09_07b:nil];
    [self setPZL09_08b:nil];
    [self setPZL09_09b:nil];
    [self setPZL09_11b:nil];
    [self setPZL09_12b:nil];
    [self setPZL09_13b:nil];
    [self setPZL09_14b:nil];
    [self setPZL09_15b:nil];
    [self setPZL09_17b:nil];
    [self setPZL09_19b:nil];
    [self setPZL09_18b:nil];
    [self setPZL09_20b:nil];
    [self setPZL09_22b:nil];
    [self setPZL09_23b:nil];
    [self setPZL09_24b:nil];
    [self setPZL09_25b:nil];
    [self setPZL09_27b:nil];
    [self setPZL09_28b:nil];
    [self setPZL09_29b:nil];
    [self setPZL09_30b:nil];
    [self setPZL09_31b:nil];
    [self setPZL09_33b:nil];
    [self setPZL09_32b:nil];
    [self setPZL09_31b:nil];
    [self setPZL09_Jenny01:nil];
    [self setPZL09_Miaow01:nil];
    [self setImageSection1:nil];
    [self setImageSection2:nil];
    [self setImageSection3:nil];
    [self setBimages:nil];
    [self setScroller:nil];
    [self setPuzzleView:nil];
    [self setBackground1:nil];
    [self setBackground2:nil];
    [self setBackground3:nil];
    [self setPZL09_29a:nil];
    [self setPZL09_29c:nil];
    [self setPZL09_23a:nil];
    [self setPZL09_23c:nil];
    [self setPZL09_31a:nil];
    [self setPZL09_31c:nil];
    [self setPZL09_14a:nil];
    [self setPZL09_14c:nil];
    [self setPZL09_27a:nil];
    [self setPZL09_27c:nil];
    [self setPZL09_01a:nil];
    [self setPZL09_01c:nil];
    [self setPZL09_03a:nil];
    [self setPZL09_03c:nil];
    [self setPZL09_02a:nil];
    [self setPZL09_02c:nil];
    [self setPZL09_04a:nil];
    [self setPZL09_04c:nil];
    [self setPZL09_04a:nil];
    [self setPZL09_05a:nil];
    [self setPZL09_05c:nil];
    [self setPZL09_06a:nil];
    [self setPZL09_05c:nil];
    [self setPZL09_06c:nil];
    [self setPZL09_07a:nil];
    [self setPZL09_07c:nil];
    [self setPZL09_08a:nil];
    [self setPZL09_08c:nil];
    [self setPZL09_09a:nil];
    [self setPZL09_09c:nil];
    [self setPZL09_11a:nil];
    [self setPZL09_11c:nil];
    [self setPZL09_12a:nil];
    [self setPZL09_12c:nil];
    [self setPZL09_13a:nil];
    [self setPZL09_13c:nil];
    [self setPZL09_15a:nil];
    [self setPZL09_15c:nil];
    [self setPZL09_17a:nil];
    [self setPZL09_17c:nil];
    [self setPZL09_19a:nil];
    [self setPZL09_19c:nil];
    [self setPZL09_22a:nil];
    [self setPZL09_22c:nil];
    [self setPZL09_18a:nil];
    [self setPZL09_18c:nil];
    [self setPZL09_32a:nil];
    [self setPZL09_32c:nil];
    [self setPZL09_20a:nil];
    [self setPZL09_20c:nil];
    [self setPZL09_21a:nil];
    [self setPZL09_21c:nil];
    [self setPZL09_24a:nil];
    [self setPZL09_24c:nil];
    [self setPZL09_25a:nil];
    [self setPZL09_25c:nil];
    [self setPZL09_28a:nil];
    [self setPZL09_28c:nil];
    [self setPZL09_30a:nil];
    [self setPZL09_30c:nil];
    [self setPZL09_33a:nil];
    [self setPZL09_33c:nil];
    [self setAimages:nil];
    [self setCimages:nil];
    [self setPZL09_21b:nil];
	[self setPZL_Instruction_Play:nil];
	[self setPZL_Instruction_Skip:nil];
    [super viewDidUnload];
}
@end
