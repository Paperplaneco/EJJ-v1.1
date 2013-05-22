//
//  SV17.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "SV17.h"
#import <QuartzCore/QuartzCore.h>
#import "Chipmunk-iPhone/chipmunk.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#define ARM_POSITION cpv (334, 359)
#define BALL_POSITION cpv (376, 340)
#define ARM_MAX_ANGLE -100
#define ARM_MIN_ANGLE 0

@interface SV17 ()
{
    NSTimer *timer, *collideTimer, *bounceTimer;
    NSInteger collideCount;
    CGFloat totalDeg;

    cpSpace *space;
    cpBody *ballBody;
    
    CGRect clown01Mouth, clown02Mouth, clown03Mouth;
    
    UIImageView *clown01Image, *clown02Image, *clown03Image;
    
    BOOL clownCollision[3];
    BOOL collideFloor;
    
    int bounceCount;
}

@property (weak, nonatomic) IBOutlet UIImageView *BG;
@property (weak, nonatomic) IBOutlet UIImageView *Ball;
@property (weak, nonatomic) IBOutlet UIImageView *Arm;
@property (weak, nonatomic) IBOutlet UIImageView *Jenny;
@property (weak, nonatomic) IBOutlet UIImageView *Clown01;
@property (weak, nonatomic) IBOutlet UIImageView *Clown02;
@property (weak, nonatomic) IBOutlet UIImageView *Clown03;
@property (weak, nonatomic) IBOutlet UIImageView *Instruction;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property NSTimer *timer;
@property NSTimer *collideTimer;

@property NSUserDefaults *defaults;

@end

@implementation SV17

@synthesize timer, collideTimer;
@synthesize defaults = _defaults;

id param;

- (void) createGround
{
    cpBody *groundBody = cpBodyNewStatic();
    
    cpVect leftEdge = cpv(437, 394);
    cpVect rightEdge = cpv(1024, 608);
    
    cpFloat radius = 10;
    cpShape *groundShape = cpSegmentShapeNew(groundBody, leftEdge, rightEdge, radius);
    
    groundShape->e = 1.0;
    groundShape->u = 1.0;
    groundShape->collision_type = 2;
    
    cpSpaceAddShape(space, groundShape);
    
    cpBody *wallBody = cpBodyNewStatic();
    
    cpVect topEdge = cpv(1024, 0);
    cpVect bottomEdge = cpv(1024, 608);
    
    cpShape *wallShape = cpSegmentShapeNew(wallBody, bottomEdge, topEdge, radius);
    
    wallShape->e = 1.0;
    wallShape->u = 1.0;
    
    cpSpaceAddShape(space, wallShape);
}

- (void) setupChipmunk
{
    cpInitChipmunk();
    
    space = cpSpaceNew();
    space -> gravity = cpv(0, 400);
    
    ballBody = cpBodyNew(100, INFINITY);
    ballBody -> p = self.Ball.center;
    cpBodySetMass(ballBody, 1);
    cpSpaceAddBody(space, ballBody);
    
    cpShape *ballShape = cpCircleShapeNew(ballBody, 20, cpvzero);
    ballShape -> e = 0.5;
    ballShape -> u = 0.8;
    ballShape -> data = (__bridge void*)(self.Ball);
    ballShape -> collision_type = 1;
    cpSpaceAddShape(space, ballShape);
    
    [self createGround];
    
    cpSpaceAddCollisionHandler(space, 2, 1, &ballCollideGround, nil, nil, nil, nil);
}

static int ballCollideGround (cpArbiter *arb, cpSpace *space, void *data)
{
    cpShape *a, *b;
    cpArbiterGetShapes(arb, &a, &b);

    // Call Obj-C method
    [param setupBallTimer];
    
    return YES;
}

- (void) tick: (NSTimer *) timer
{
    cpSpaceStep(space, 1.0/60.0);
    cpSpaceEachShape(space, &updateBallShape, nil);
}

void updateBallShape (void *ptr)
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    static float frameStartX = -1;
    static float frameStartY = -1;
    CGPoint center= CGPointMake(CGRectGetMinX(self.Arm.bounds), CGRectGetMaxY(self.Arm.bounds));
    static float armlength;
    static CGPoint frameCenter;
    
    if (frameStartX == -1){
        frameStartX = CGRectGetMaxX(self.Arm.frame);
        frameStartY =  CGRectGetMinY(self.Arm.frame) ;
        frameCenter = CGPointMake(CGRectGetMinX(self.Arm.frame), CGRectGetMaxY(self.Arm.frame));
        armlength = sqrt(pow(fabs(self.Ball.center.x -frameStartX),2) + pow(fabs(self.Ball.center.y-frameStartY), 2));
        NSLog(@"length = %g",armlength);
    }
    
    if ([touch view] == self.Arm)
    {
        CGPoint currentTouchPoint = [touch locationInView:self.Arm];
        CGPoint previousTouchPoint = [touch previousLocationInView:self.Arm];
        
        CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
        
        totalDeg += RADIANS_TO_DEGREES(angleInRadians);

        // Limit the angle
        if (totalDeg > -100 && totalDeg < 0)
            self.Arm.transform = CGAffineTransformRotate(self.Arm.transform, angleInRadians);
        else if (totalDeg < -100)
            totalDeg = -100;
        else if (totalDeg > 0)
            totalDeg = 0;

        // frame change
        float rads = DEGREES_TO_RADIANS(totalDeg-35.0);
        rads*=.75;
        float newArmLength = armlength * (1.0-(totalDeg/-100.0)*0.25);
        self.Ball.center =CGPointMake(frameCenter.x+cos(rads)*newArmLength*M_PI, frameCenter.y+sin(rads)*newArmLength*M_PI);
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[touches anyObject] view] == self.Arm)
    {
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
		
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        self.collideTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(collisionDetection) userInfo:nil repeats:YES];
        
        cpBodyApplyImpulse(ballBody, cpv(300, totalDeg * 5), cpvzero);
        
        // Reset the arm degree
        totalDeg = 0;
        
        // Reset the arm position
        self.Arm.transform = CGAffineTransformMakeRotation(0);
		self.Arm.userInteractionEnabled = NO;
		
		self.Instruction.hidden = YES;
    }
}

- (void) collisionDetection
{
    // Collision with clown 01
    if (CGRectIntersectsRect(clown01Mouth, self.Ball.frame) && clownCollision[0])
    {
        clownCollision[0] = NO;
        collideCount++;

        [self.timer invalidate];
        [self.collideTimer invalidate];
        
        clown01Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17_Ball.png"]];
        clown01Image.center = clown01Mouth.origin;
        [self.view addSubview:clown01Image];
        
        // Reset the ball position
        self.Ball.center = BALL_POSITION;
        ballBody->p = BALL_POSITION;
        ballBody->v = cpvzero;
        self.Arm.userInteractionEnabled = YES;
		
        if (collideCount == 3)
            bounceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(bounceAllClown) userInfo:nil repeats:YES];
        else
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Clown01.center = CGPointMake(self.Clown01.center.x, self.Clown01.center.y - 30);
                clown01Image.center = CGPointMake(clown01Image.center.x, clown01Image.center.y - 30);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    self.Clown01.center = CGPointMake(self.Clown01.center.x, self.Clown01.center.y + 30);
                    clown01Image.center = CGPointMake(clown01Image.center.x, clown01Image.center.y + 30);
                }];
            }];
        
        [self checkWinLose];
        
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    }
    
    // Collision with clown 02
    else if (CGRectIntersectsRect(clown02Mouth, self.Ball.frame) && clownCollision[1])
    {
        clownCollision[1] = NO;
        collideCount++;
        
        [self.timer invalidate];
        [self.collideTimer invalidate];
        
        clown02Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17_Ball.png"]];
        clown02Image.center = clown02Mouth.origin;
        [self.view addSubview:clown02Image];
        
        // Reset the ball position
        self.Ball.center = BALL_POSITION;
        ballBody->p = BALL_POSITION;
        ballBody->v = cpvzero;
        self.Arm.userInteractionEnabled = YES;
		
        if (collideCount == 3)
            bounceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(bounceAllClown) userInfo:nil repeats:YES];
        else
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Clown02.center = CGPointMake(self.Clown02.center.x, self.Clown02.center.y - 30);
                clown02Image.center = CGPointMake(clown02Image.center.x, clown02Image.center.y - 30);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    self.Clown02.center = CGPointMake(self.Clown02.center.x, self.Clown02.center.y + 30);
                    clown02Image.center = CGPointMake(clown02Image.center.x, clown02Image.center.y + 30);
                }];
            }];
        
        [self checkWinLose];
        
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    }
    
    // Collision with clown 03
    else if (CGRectIntersectsRect(clown03Mouth, self.Ball.frame) && clownCollision[2])
    {
        clownCollision[2] = NO;
        collideCount++;
        
        [self.timer invalidate];
        [self.collideTimer invalidate];
        
        clown03Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17_Ball.png"]];
        clown03Image.center = clown03Mouth.origin;
        [self.view addSubview:clown03Image];
        
        // Reset the ball position
        self.Ball.center = BALL_POSITION;
        ballBody->p = BALL_POSITION;
        ballBody->v = cpvzero;
		self.Arm.userInteractionEnabled = YES;
        
        if (collideCount == 3)
            bounceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(bounceAllClown) userInfo:nil repeats:YES];
        else
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.Clown03.center = CGPointMake(self.Clown03.center.x, self.Clown03.center.y - 30);
                clown03Image.center = CGPointMake(clown03Image.center.x, clown03Image.center.y - 30);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    self.Clown03.center = CGPointMake(self.Clown03.center.x, self.Clown03.center.y + 30);
                    clown03Image.center = CGPointMake(clown03Image.center.x, clown03Image.center.y + 30);
                }];
            }];
        
        [self checkWinLose];
        
        if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
    }
}

- (void) checkWinLose
{
    if (collideCount == 3)
    {
        [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(presentWinView) userInfo:nil repeats:NO];
    }
}

- (void) presentWinView
{
    clown01Image.hidden = YES;
    clown02Image.hidden = YES;
    clown03Image.hidden = YES;
	
	self.Instruction.hidden = YES;
}

- (void) setupBallTimer
{
    if (collideFloor)
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(setupBall) userInfo:nil repeats:NO];
    collideFloor = NO;
}

- (void) setupBall
{
    [self.timer invalidate];
    [self.collideTimer invalidate];
    
    [self checkWinLose];
    
    collideFloor = YES;
    self.Arm.userInteractionEnabled = YES;
	
    UIImageView *ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17_Ball.png"]];
    ballView.center = self.Ball.center;
    [self.view addSubview:ballView];
    
    self.Ball.center = BALL_POSITION;
    ballBody->p = BALL_POSITION;
	ballBody->v = cpvzero;
    
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
}

- (void) bounceAllClown
{	
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.Clown01.center = CGPointMake(self.Clown01.center.x, self.Clown01.center.y - 30);
        self.Clown02.center = CGPointMake(self.Clown02.center.x, self.Clown02.center.y - 30);
        self.Clown03.center = CGPointMake(self.Clown03.center.x, self.Clown03.center.y - 30);
        
        clown01Image.center = CGPointMake(clown01Image.center.x, clown01Image.center.y - 30);
        clown02Image.center = CGPointMake(clown02Image.center.x, clown02Image.center.y - 30);
        clown03Image.center = CGPointMake(clown03Image.center.x, clown03Image.center.y - 30);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            self.Clown01.center = CGPointMake(self.Clown01.center.x, self.Clown01.center.y + 30);
            self.Clown02.center = CGPointMake(self.Clown02.center.x, self.Clown02.center.y + 30);
            self.Clown03.center = CGPointMake(self.Clown03.center.x, self.Clown03.center.y + 30);
            
            clown01Image.center = CGPointMake(clown01Image.center.x, clown01Image.center.y + 30);
            clown02Image.center = CGPointMake(clown02Image.center.x, clown02Image.center.y + 30);
            clown03Image.center = CGPointMake(clown03Image.center.x, clown03Image.center.y + 30);
        }];
    }];
    bounceCount++;

    if (bounceCount > 2)
	{
		[bounceTimer invalidate];
		
		clownCollision[0] = YES;
		clownCollision[1] = YES;
		clownCollision[2] = YES;
		bounceCount = 0;
		collideCount = 0;
	}
}

- (IBAction)miaoTapped:(UITapGestureRecognizer *)sender
{
	self.Instruction.hidden = NO;
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
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self setupChipmunk];
    param = self;
    
    [self.voiceOverPlayer setAudioFile:@"17_VO.mp3"];
    [self.SFX01 setAudioFile:@"17_hit.mp3"];
    [self.SFX02 setAudioFile:@"17_miss.mp3"];
    [self.SFX03 setAudioFile:@"17_win.mp3"];
	[self.SFX04 setAudioFile:@"17_throw.mp3"];
	[self.SFX05 setAudioFile:@"17_loop.mp3"];
	
	self.SFX05.repeats = YES;
	
    if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
    if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"] &&
		[[self.defaults objectForKey:@"play voiceover"] isEqualToString:@"YES"])
		[self.voiceOverPlayer play];
	
	[self.defaults setObject:@"YES" forKey:@"play voiceover"];
	[self.defaults synchronize];
    
    self.Label.font = [UIFont fontWithName:@"AFontwithSerifs" size:26];
    
	self.Instruction.hidden = YES;
	
    self.Arm.layer.anchorPoint = CGPointMake(0.2, 0.8);
    self.Arm.layer.position = CGPointMake(280, 385);
    
    clown01Mouth = CGRectMake(800, 210, 10, 10);
    clown02Mouth = CGRectMake(924, 359, 10, 10);
    clown03Mouth = CGRectMake(654, 324, 10, 10);
    
    clownCollision[0] = YES;
    clownCollision[1] = YES;
    clownCollision[2] = YES;
    bounceCount = 0;
    collideCount = 0;
    collideFloor = YES;
	
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
    self.Ball = nil;
    self.Arm = nil;
    self.Jenny = nil;
    self.Clown01 = nil;
    self.Clown02 = nil;
    self.Clown03 = nil;
    self.Instruction = nil;
    self.Label = nil;
    
    self.voiceOverPlayer = nil;
    self.SFX01 = nil;
    self.SFX02 = nil;
    self.SFX03 = nil;
	self.SFX04 = nil;
	self.SFX05 = nil;
	
	clown01Image = nil;
	clown02Image = nil;
	clown03Image = nil;
	
	timer = nil;
	collideTimer = nil;
	bounceTimer = nil;
    
    self.defaults = nil;
}

- (void)viewDidUnload {
	[self setBtnBack:nil];
	[self setBtnNext:nil];
	[super viewDidUnload];
}
@end
