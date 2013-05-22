//
//  SV12.m
//  JennyJones
//
//  Created by Zune Moe on 21/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV12.h"
#import "Chipmunk-iPhone/chipmunk.h"

#define JENNY_POSITION CGPointMake(114,418)
#define BIRD_BOY_POSITION CGPointMake(292,422)
#define PLANE_BOY_POSITION CGPointMake(835,560)
#define BIRD_POSITION CGPointMake(890,206)
#define PLANE_POSITION CGPointMake(1080,196)
#define BALL_POSITION CGPointMake(442,297)

@interface SV12 ()
{
	NSTimer *timer;
    CGPoint offset;
    
    CGRect PlaneBoyRect, BirdBoyRect;
    
	cpSpace *space;
	cpBody *ballBody;
	
    float random;
    BOOL ballTouchedTop;
    BOOL p1Collide, p2Collide;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Bird;
@property (weak, nonatomic) IBOutlet UIImageView *Plane;
@property (weak, nonatomic) IBOutlet UIImageView *PlaneBoy;
@property (weak, nonatomic) IBOutlet UIImageView *BirdBoy;
@property (weak, nonatomic) IBOutlet UIImageView *BallOff;
@property (weak, nonatomic) IBOutlet UIImageView *BallOn;
@property (weak, nonatomic) IBOutlet UIImageView *Jenny;
@property (weak, nonatomic) IBOutlet UIImageView *Miao01;
@property (weak, nonatomic) IBOutlet UIImageView *Miao02;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSTimer *timer;

@property NSUserDefaults *defaults;

@end

@implementation SV12

@synthesize timer;
@synthesize defaults = _defaults;

id parameter;

- (void) setupChipmunk
{
	cpInitChipmunk();
	
	// Create space
	space = cpSpaceNew();
	space -> gravity = cpv(0, 400);
	
	// Create ball body
	ballBody = cpBodyNew(100, INFINITY);
	ballBody -> p = self.BallOn.center;
	cpBodySetMass(ballBody, 1);
	cpSpaceAddBody(space, ballBody);
	cpShape *ballShape = cpCircleShapeNew(ballBody, 20, cpvzero);
	ballShape -> e = 0.5;
	ballShape -> u = 0.8;
	ballShape -> data = (__bridge void*)(self.BallOn);
	ballShape -> collision_type = 1;
	cpSpaceAddShape(space, ballShape);
	
	// Create ground
	cpBody *groundBody = cpBodyNewStatic();
	cpVect leftEdge = cpv(0, 768);
	cpVect rightEdge = cpv(1024, 768);
	cpFloat radius = 10;
	cpShape *groundShape = cpSegmentShapeNew(groundBody, leftEdge, rightEdge, radius);
	groundShape -> e = 0.4;
	groundShape -> u = 1.0;
	groundShape -> collision_type = 2;
	cpSpaceAddShape(space, groundShape);
	
	// Create left wall
	cpBody *leftWallBody = cpBodyNewStatic();
	cpVect topLeft = cpv(0, 0);
	cpVect botLeft = cpv(0, 768);
	cpShape *leftWallShape = cpSegmentShapeNew(leftWallBody, botLeft, topLeft, radius);
	leftWallShape -> e = 0.0;
	leftWallShape -> u = 1.0;
	leftWallShape -> collision_type = 3;
	cpSpaceAddShape(space, leftWallShape);
	
	// Create right wall
	cpBody *rightWallBody = cpBodyNewStatic();
	cpVect topRight = cpv(1024, 0);
	cpVect botRight = cpv(1024, 768);
	cpShape *rightWallShape = cpSegmentShapeNew(rightWallBody, botRight, topRight, radius);
	rightWallShape -> e = 0.0;
	rightWallShape -> u = 1.0;
	rightWallShape -> collision_type = 4;
	cpSpaceAddShape(space, rightWallShape);
	
	// Add collision handler
	cpSpaceAddCollisionHandler(space, 1, 2, &ballCollideGround, nil, nil, nil, nil);
	cpSpaceAddCollisionHandler(space, 1, 3, &ballCollideLeftWall, nil, nil, nil, nil);
	cpSpaceAddCollisionHandler(space, 1, 4, &ballCollideRightWall, nil, nil, nil, nil);
}

static int ballCollideGround (cpArbiter *arb, cpSpace *space, void *data)
{
	cpShape *a, *b;
	cpArbiterGetShapes(arb, &a, &b);
	
	// Call Obj-C method
	[parameter checkWinnerOnBallCollideGround];
	
	return YES;
}

static int ballCollideLeftWall (cpArbiter *arb, cpSpace *space, void *data)
{
	cpShape *a, *b;
	cpArbiterGetShapes(arb, &a, &b);
	
	// Call Obj-C method
	[parameter planeBoyWin];
	
	return YES;
}

static int ballCollideRightWall (cpArbiter *arb, cpSpace *space, void *data)
{
	cpShape *a, *b;
	cpArbiterGetShapes(arb, &a, &b);
	
	// Call Obj-C method
	[parameter birdBoyWin];
	
	return YES;
}

- (void) checkWinnerOnBallCollideGround
{
	if (self.BallOn.center.x > 670) [self birdBoyWin];
	else [self planeBoyWin];
}

- (void) ballCollideBirdBoy
{
	if (CGRectIntersectsRect(BirdBoyRect, self.BallOn.frame) && p1Collide == NO)
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX06 play];
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
		
		p1Collide = YES;
		p2Collide = NO;
		
		[UIView animateWithDuration:1.0 animations:^{
			self.Bird.center = CGPointMake(self.Bird.center.x - 50, self.Bird.center.y);
		}];
		
		ballBody -> v = cpvzero;
		cpBodyApplyImpulse(ballBody, cpv(350, -250), cpvzero);
	}
}

- (void) ballCollidePlaneBoy
{
	if (CGRectIntersectsRect(PlaneBoyRect, self.BallOn.frame) && p2Collide == NO)
	{
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX06 play];
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
		
        p1Collide = NO;
        p2Collide = YES;
		
        [UIView animateWithDuration:1.0 animations:^{
            self.Plane.center = CGPointMake(self.Plane.center.x - 50, self.Plane.center.y);
        }];
		
		ballBody -> v = cpvzero;
		cpBodyApplyImpulse(ballBody, cpv(-350, -250), cpvzero);
	}
}

- (void) tick:(NSTimer *) tmr
{
	cpSpaceStep(space, 1.0/60.0);
	cpSpaceEachShape(space, &updateBall, nil);
	
	[self ballCollideBirdBoy];
	[self ballCollidePlaneBoy];
	
	// BirdBoy Win
    if(self.Bird.center.x < 0 - self.Bird.frame.size.width/2) [self birdBoyWin];
}

void updateBall (void *ptr)
{
	// Get our shape
    cpShape *shape = (cpShape*)ptr;
	
    // Make sure everything is as expected or tip & exit
    if(shape == nil || shape->body == nil || shape->data == nil) {
        //NSLog(@"Unexpected shape please debug here...");
        return;
    }
    
    // Lastly checks if the object is an UIView of any kind
    // and update its position accordingly
    if([(__bridge UIView*)shape->data isKindOfClass:[UIView class]])
        [(__bridge UIView *)shape->data setCenter:CGPointMake(shape->body->p.x, shape->body->p.y)];
    else
        NSLog(@"The shape data wasn't updateable using this code.");
}

- (void) birdBoyWin
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
	
	self.BirdBoy.image = [UIImage imageNamed:@"BoyA_Won.png"];
	
	[UIView animateWithDuration:1.0 animations:^{
		self.Bird.center = CGPointMake(0 - self.Bird.frame.size.width, self.Bird.center.y);
	}];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resetObjects) userInfo:nil repeats:NO];
}

- (void) planeBoyWin
{
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
	
	self.PlaneBoy.image = [UIImage imageNamed:@"BoyB_Won.png"];
	
	[UIView animateWithDuration:3 animations:^{
		self.Plane.center = CGPointMake(self.Bird.center.x, self.Plane.center.y);
	}];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resetObjects) userInfo:nil repeats:NO];
}

- (void) resetObjects
{
	self.Jenny.hidden = NO;
	self.Jenny.center = JENNY_POSITION;
	self.BallOff.hidden = NO;
	self.BallOn.hidden = YES;
	self.BirdBoy.center = BIRD_BOY_POSITION;
	self.PlaneBoy.center = PLANE_BOY_POSITION;
	self.Bird.center = BIRD_POSITION;
	self.Plane.center = PLANE_POSITION;
	
	self.Miao01.hidden = YES;
	self.Miao02.hidden = NO;
	
	self.BirdBoy.image = [UIImage imageNamed:@"12_BirdBoy.png"];
	self.PlaneBoy.image = [UIImage imageNamed:@"12_PlaneBoy.png"];
	
	self.BallOn.center = BALL_POSITION;
	ballBody -> p = BALL_POSITION;
	ballBody -> v = cpvzero;
	
	p1Collide = NO;
	p2Collide = NO;
	
	[self.timer invalidate];
}

- (IBAction)jennyTapped:(UITapGestureRecognizer *)sender
{
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
}

- (IBAction)startTapped:(UITapGestureRecognizer *)sender
{
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	
    [UIView animateWithDuration:1.0 animations:^{
        self.Jenny.center = CGPointMake(-140, 418);
    }];
    self.Miao01.hidden = YES;
    self.Miao02.hidden = NO;
    
    self.BallOff.hidden = YES;
    self.BallOn.hidden = NO;
	
	ballBody -> v = cpvzero;
	cpBodyApplyImpulse(ballBody, cpv(350, -250), cpvzero);
}

- (IBAction)miaoTapped:(UITapGestureRecognizer *)sender
{
	self.Miao01.hidden = NO;
	self.Miao02.hidden = YES;
	
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideMiaoInstruction) userInfo:nil repeats:NO];
}

- (void) hideMiaoInstruction
{
	self.Miao01.hidden = YES;
	self.Miao02.hidden = NO;
}

- (void) birdBoyPanGesture:(UIPanGestureRecognizer *) recognizer
{
	CGPoint point = [recognizer locationInView:self.view];
	
	if (point.x < 450 && point.y > 370)
	{
		self.BirdBoy.center = CGPointMake(point.x, point.y);
		BirdBoyRect = CGRectMake(self.BirdBoy.center.x + 45, self.BirdBoy.center.y - 128, 15, 45);
	}
}

- (void) planeBoyPanGesture:(UIPanGestureRecognizer *) recognizer
{
	CGPoint point = [recognizer locationInView:self.view];
	
	if (point.x > 570 && point.y > 370)
	{
		self.PlaneBoy.center = CGPointMake(point.x, point.y);
		PlaneBoyRect = CGRectMake(self.PlaneBoy.center.x - 90, self.PlaneBoy.center.y - 143, 15, 45);
	}
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
		self.btnNext.alpha = 1.0;
		self.btnNext.userInteractionEnabled = YES;
	}
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	[self setupChipmunk];
    
	parameter = self;
	
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.voiceOverPlayer setAudioFile:@"12_VO.mp3"];
    [self.SFX01 setAudioFile:@"12_SFX01.mp3"];
    [self.SFX02 setAudioFile:@"12_SFXBird.mp3"];
    [self.SFX03 setAudioFile:@"12_SFXPlane.mp3"];
    [self.SFX04 setAudioFile:@"12_SFXWin.mp3"];
    [self.SFX05 setAudioFile:@"12_SFXLose.mp3"];
    [self.SFX06 setAudioFile:@"12_hit.mp3"];
	
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"] &&
		[[self.defaults objectForKey:@"play voiceover"] isEqualToString:@"YES"])
		[self.voiceOverPlayer play];
	
	[self.defaults setObject:@"YES" forKey:@"play voiceover"];
	[self.defaults synchronize];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:28];
    
    self.Miao01.hidden = YES;
    self.Miao02.hidden = NO;
    
    self.BallOff.hidden = NO;
    self.BallOn.hidden = YES;
    
    p1Collide = NO;
    p2Collide = NO;
    
    BirdBoyRect = CGRectMake(self.BirdBoy.center.x + 42, self.BirdBoy.center.y - 89, 56, 74);
    PlaneBoyRect = CGRectMake(self.PlaneBoy.center.x - 85, self.PlaneBoy.center.y - 77, 56, 74);
	
	UIPanGestureRecognizer *birdBoyPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(birdBoyPanGesture:)];
	[self.BirdBoy addGestureRecognizer:birdBoyPan];
	
	UIPanGestureRecognizer *planeBoyPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(planeBoyPanGesture:)];
	[self.PlaneBoy addGestureRecognizer:planeBoyPan];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navShow:) name:@"NavShow" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceoverPlayerFinishPlaying:) name:@"VoiceoverPlayerFinishPlaying" object:nil];
	self.btnNext.alpha = 0.25;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"NO"])
		[[NSNotificationCenter defaultCenter] postNotificationName:@"VoiceoverPlayerFinishPlaying" object:@"YES"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.BG = nil;
    self.Bird = nil;
    self.Plane = nil;
    self.PlaneBoy = nil;
    self.BirdBoy = nil;
    self.BallOff = nil;
    self.BallOn = nil;
    self.Jenny = nil;
    self.Miao01 = nil;
    self.Miao02 = nil;
    self.Label = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
    self.SFX04 = nil;
    self.SFX05 = nil;
	self.SFX06 = nil;
    
	self.timer = nil;
    self.defaults = nil;
	
	ballBody -> v = cpvzero;
	ballBody -> p = BALL_POSITION;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
