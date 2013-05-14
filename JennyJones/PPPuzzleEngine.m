//
//  PPPuzzleEngine.m
//  JennyJones
//
//  Created by Corey Manders on 10/7/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPuzzleEngine.h"
#import <AVFoundation/AVFoundation.h>
#import "PulsingUIView.h"

@interface PPPuzzleEngine()<PPWatchViewDelegate>
{
      CAEmitterLayer *emitter[20];
}
@property (strong,nonatomic) NSArray * color;
@property (strong,nonatomic) NSArray * bwRound;
@property (strong,nonatomic) NSArray * bwSquare;
@property (strong, nonatomic) UIImageView * bg1;
@property (strong, nonatomic) UIImageView * bg2;
@property (strong, nonatomic) UIImageView * bg3;
@property (strong, nonatomic) UIImageView * reveal1;
@property (strong, nonatomic) UIImageView * reveal2;
@property (strong, nonatomic) UIImageView * reveal3;

@property (strong) NSMutableArray * foundArray;

@property (strong) AVAudioPlayer * player;
@property (strong) AVAudioPlayer * revealPlayer;
@property (assign) int musicCounter;

@property (strong) NSTimer * timer;
@property (strong) NSArray *randomSet;
@property int foundCount;

@end

@implementation PPPuzzleEngine

@synthesize color = _color;
@synthesize bwRound = _bwRound;
@synthesize bwSquare = _bwSquare;
@synthesize bg1 = _bg1;
@synthesize bg2 = _bg2;
@synthesize bg3 = _bg3;
@synthesize reveal1 = _reveal1;
@synthesize reveal2 = _reveal2;
@synthesize reveal3 = _reveal3;
@synthesize emitter2 = _emitter2;

@synthesize numberOfHiddenObjects = _numberOfHiddenObjects;
@synthesize foundArray = _foundArray;
@synthesize timer = _timer;
@synthesize randomSet = _randomSet;
@synthesize player = _player;
@synthesize revealPlayer = _revealPlayer;
@synthesize musicCounter = _musicCounter;
@synthesize numberOfMusicFiles = _numberOfMusicFiles;
@synthesize hostView = _hostView;
@synthesize puzzleTimer = _puzzleTimer;
@synthesize puzzleTime = _puzzleTime;
@synthesize delegate = _delegate;
@synthesize hasReplicatedObjects = _hasReplicatedObjects;
@synthesize replicatedObjectsA = _replicatedObjectsA;
@synthesize replicatedObjectsB = _replicatedObjectsB;
@synthesize replicatedObjectsC = _replicatedObjectsC;
@synthesize additionalImages = _additionalImages;
@synthesize additionalReveal = _additionalReveal;
@synthesize foundCount = _foundCount;

-(void) tempTapCallback:(UITapGestureRecognizer*) recognizer
{

    UIImageView * tappedView = (UIImageView*)recognizer.view;

    for (UIImageView * view in self.bwRound)
        if (view.frame.size.height == tappedView.frame.size.height && view.frame.size.width == tappedView.frame.size.width ){
            [self handleTap:[view.gestureRecognizers lastObject]];
            return;
        }
   
}

-(void) pulseObjects{

    for (int i = 0;i< self.bwRound.count;i++){
        PulsingUIView * temp= [self.bwRound objectAtIndex:i];
        [temp pulse];
    }
}
-(UIView *)giveHintUsingEmitter
{
    for (int i = 0;i< self.bwRound.count;i++){
        UIImageView * temp = [self.bwRound objectAtIndex:i];
        if (temp.gestureRecognizers.count >0){

            [self doEmitterMagicAtPoint:temp.center scale:0.5];
            return temp;
        }
    }
    return nil;
}
-(UIView*) giveHintUsingEmitterWithContentOffset:(float)x
{
	for (int i = 0;i< self.bwRound.count;i++){
        UIImageView * temp = [self.bwRound objectAtIndex:i];
		CGPoint tempCenter = temp.center;
		tempCenter.x = tempCenter.x-x;
        if (temp.gestureRecognizers.count >0){

            [self doEmitterMagicAtPoint:tempCenter scale:0.5];
            return temp;
        }
    }
    return nil;
}
-(void)timerDidExpire:(PPWatchView *)sender
{
    [self clearPage];
    [self startEngine];
    
    [self.puzzleTimer stopTimer];
    [self.puzzleTimer startTimer:self.puzzleTime];
}
-(void) clearPage
{
    for (int i=0; i<self.bwRound.count; i++){ 
        ((UIImageView*)[self.color objectAtIndex:i]).alpha = 1.0;
        ((UIImageView*)[self.bwSquare objectAtIndex:i]).alpha = 1.0;
        ((UIImageView*)[self.bwRound objectAtIndex:i]).alpha = 1.0;
        
    }
    if (self.bg1)self.bg1.alpha = 1.0;
    if (self.bg2)self.bg2.alpha = 1.0;
    if (self.bg3)self.bg3.alpha = 1.0;
    self.foundCount = 0;
    for (UIImageView * view in self.additionalImages) {
        view.alpha = 1.0;
    }
    for (UIImageView * view in self.additionalReveal) {
        view.alpha = 0.0;
        view.hidden = YES;
    }
    
    for (NSNumber *num in self.randomSet){
        UIImageView *temp = [self.bwRound objectAtIndex:[num intValue]];
        temp.userInteractionEnabled = NO;
        [temp removeGestureRecognizer:[temp.gestureRecognizers lastObject]];
        
    }
    for (int i = 0;i<self.foundArray.count;i++){
        [self.foundArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
    }
    for (UIImageView * im in self.bwSquare) im.hidden = NO;
        for (PulsingUIView * im in self.bwRound) im.hidden = YES;
    for (UIImageView * im in self.color) im.hidden = YES;
    
    [self.puzzleTimer stopTimer];
  
}
-(void) reset
{
    [self clearPage];
    [self startEngine];
}
-(id) initWithBWObjects:(NSArray *)ibwRound color:(NSArray*)icolor bwSquare:(NSArray*)ibwSquare
             backgound1:(UIImageView*)ibg1 background2:(UIImageView*)ibg2 background3:(UIImageView*)ibg3
                reveal1:(UIImageView*)ireveal1 reveal2:(UIImageView*)ireveal2  reveal3:(UIImageView*)ireveal3
{
    self.color = icolor;
    self.bwRound = ibwRound;

    self.bg1 = ibg1;
    self.bg2 = ibg2;
    self.bg3 = ibg3;
    self.bwSquare = ibwSquare;

    self.puzzleTime = 0.0;
    self.numberOfHiddenObjects = 3;
    self.reveal1 = ireveal1;
    self.reveal2 = ireveal2;
    self.reveal3 = ireveal3;

    return self;
}

-(void)stopEmitter:(NSTimer *)timer
{
    CAEmitterLayer * myEmitter = (CAEmitterLayer *)[timer userInfo];
    [myEmitter removeFromSuperlayer];
    myEmitter = nil;
}


#define MRAND_MAX 0x100000000
-(void) doEmitterMagicAtPoint:(CGPoint) pt scale:(float)scale;
{
    float multiplier = 0.25f;

    //Create the emitter layer
    self.emitter2 = [CAEmitterLayer layer];
    self.emitter2.emitterPosition = pt;
    self.emitter2.emitterMode = kCAEmitterLayerOutline;
    self.emitter2.emitterShape = kCAEmitterLayerCircle;
    self.emitter2.renderMode = kCAEmitterLayerBackToFront;
    self.emitter2.emitterSize = CGSizeMake(50* multiplier, 0);
    
    //Create the emitter cell
    CAEmitterCell* particle = [CAEmitterCell emitterCell];
    particle.emissionLongitude = M_PI;
    particle.birthRate = multiplier * 100.0;
    particle.lifetime = multiplier;
    particle.lifetimeRange = multiplier * 0.5*scale;
    particle.velocity = 1.5;
    particle.velocityRange = 1000*scale;
    particle.emissionRange = 10.0*scale;
    particle.scaleSpeed = 1.0; // was 0.3

    particle.blueSpeed = -2.5;
    particle.blueRange = 1.0;
    particle.redSpeed = -2.5;
    particle.redRange = 1.0;
    particle.greenSpeed = -2.5;
    particle.greenRange = 1.0;
    particle.alphaRange=0.5;
    particle.alphaSpeed =-2.5;
    UIImage * particleImage = [UIImage imageNamed:@"emitter.png"];


    particle.contents = (__bridge id)particleImage.CGImage;
    
    particle.name = @"particle";
    
    self.emitter2.emitterCells = [NSArray arrayWithObject:particle];
    [self.hostView.layer addSublayer:self.emitter2];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stopEmitter:) userInfo:self.emitter2 repeats:NO];
}

-(NSArray *)generateRandomArrayOf:(int)num from:(int)total
{
    NSMutableArray * temp = [[NSMutableArray alloc] initWithCapacity:num];
    self.foundArray = [[NSMutableArray alloc] init];
    for (int i = 0;i<total;i++) [self.foundArray addObject:[NSNumber numberWithBool:NO]];

    for(int i=0;i<num;i++){
        BOOL numExists = YES;
        int x;
        while (numExists) {
            numExists = NO;
            x = arc4random() % total;
            for (int j=0;j<temp.count;j++) //check to make sure we don't have this number
                if ([[temp objectAtIndex:j] intValue] == x) numExists = YES;
            
        }
        
        [temp addObject:[NSNumber numberWithInt:x]];

    }
    return [NSArray arrayWithArray:temp];
    
}


-(void) changeDuplicatedObjectInSetA:(UIImageView *) view toHidden:(BOOL)newState
{
    for (UIImageView * temp in self.replicatedObjectsA){
        if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width)
            temp.hidden = newState;
    }
}
-(void) changeDuplicatedObjectInSetB:(UIImageView *) view toHidden:(BOOL)newState
{
    for (UIImageView * temp in self.replicatedObjectsB){
        if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width)
            temp.hidden = newState;
    }
}
-(void) changeDuplicatedObjectInSetC:(UIImageView *) view toHidden:(BOOL)newState
{
    for (UIImageView * temp in self.replicatedObjectsC){
        if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width)
            temp.hidden = newState;
    }
}

-(void)handleTap:(UITapGestureRecognizer*) recognizer
{
    UIImageView * tapsView = (UIImageView*)recognizer.view;
    for (int i = 0;i< self.bwRound.count;i++){
        if (tapsView == [self.bwRound objectAtIndex:i]){
            [tapsView removeGestureRecognizer:recognizer];
            tapsView.gestureRecognizers=nil;
            ((UIImageView*)[self.color objectAtIndex:i]).hidden = NO;
            ((PulsingUIView*)[self.bwRound objectAtIndex:i]).hidden = YES;
             ((UIImageView*)[self.bwSquare objectAtIndex:i]).hidden = YES;
            [self changeDuplicatedObjectInSetA:[self.bwRound objectAtIndex:i] toHidden:YES];
            [self changeDuplicatedObjectInSetB:[self.color objectAtIndex:i] toHidden:NO];
            [self changeDuplicatedObjectInSetC:[self.bwSquare objectAtIndex:i] toHidden:YES];
            
            [self doEmitterMagicAtPoint:[recognizer locationInView:self.hostView] scale:1.0];
            
            
            [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(setPlayerToNextFile) userInfo:nil repeats:NO];
            self.foundCount ++;

            if (self.foundCount == self.numberOfHiddenObjects){
                self.puzzleTimer.currentCount = 0;
            
            
                if (self.reveal1){
                    self.reveal1.alpha = 0.0;
                    self.reveal1.hidden = NO;
                }
                if (self.reveal2){
                    self.reveal2.alpha = 0.0;
                    self.reveal2.hidden = NO;
                }
                if (self.reveal3){
                    self.reveal3.alpha = 0.0;
                    self.reveal3.hidden = NO;
                }
                for (UIImageView * view in self.additionalReveal){
                    view.alpha = 1.0;
                    view.hidden = NO;
               
                }
                if (!self.reveal1)NSLog(@"no REVEAL 1");
                if (!self.reveal2)NSLog(@"no REVEAL 2");
                if (!self.reveal3)NSLog(@"no REVEAL 3");
                [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     if (self.bg1){
                                         self.bg1.alpha = 0.0;
                                        if (self.reveal1) self.reveal1.alpha = 1.0;
                                     }
                                     if (self.bg2){
                                         self.bg2.alpha = 0.0;
                                         if (self.reveal2) self.reveal2.alpha = 1.0;
                                     }
                                     if (self.bg3){
                                         self.bg3.alpha = 0.0;
                                         if (self.reveal3) self.reveal3.alpha = 1.0;
                                     }
                                     for (UIImageView * view in self.additionalReveal)view.alpha = 1.0;
                                        
                                    // for (UIImageView * view in self.additionalImages) view.alpha = 0.0;
                 
                                     for (int i=0; i<self.bwRound.count; i++){
                                         ((UIImageView*)[self.color objectAtIndex:i]).alpha = 0.0;
                                         ((UIImageView*)[self.bwSquare objectAtIndex:i]).alpha = 0.0;
                                          ((UIImageView*)[self.bwRound objectAtIndex:i]).alpha = 0.0;
                                        
                                     }
                                    
                                     self.puzzleTimer.alpha = 0.0;
                                 }
                                 completion:^(BOOL finished){
                                     if (finished){
                                         if ([self.delegate respondsToSelector:@selector(puzzleCompleted:)])
                                             [self.delegate puzzleCompleted:YES];
                                     }
                                 }];
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.revealPlayer play];
                [self.puzzleTimer stopTimer];

            }
            else {
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.player play];
                self.puzzleTimer.currentCount--;
                
                //[self.puzzleTimer setNeedsDisplay];
            }
       }
    }
    
}

-(void) setPlayerToNextFile
{
    self.musicCounter++;
    if (self.musicCounter > self.numberOfMusicFiles) self.musicCounter =1;
    [self.player stop];
    self.player = nil;
    NSString * filename = [NSString stringWithFormat:@"%@/%d.mp3",[[NSBundle mainBundle] resourcePath],self.musicCounter];
    
    NSURL * url = [NSURL fileURLWithPath:filename];
    NSError * err;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    
    [self.player prepareToPlay];
}

-(void) startEngine
{
  
    // set the initial state of all object to sepia squares
    
    for (UIImageView * temp in self.bwSquare ) {
        temp.hidden = NO;
    }
    if (self.hasReplicatedObjects){
        for (UIImageView * temp in self.replicatedObjectsC ) {
            temp.hidden = NO;
        }
    }
    for (PulsingUIView * temp in self.bwRound ) {
        temp.hidden = YES;
    }
    if (self.hasReplicatedObjects){
        for (UIImageView * temp in self.replicatedObjectsA ) {
            temp.hidden = YES;
        }
    }
    for (UIImageView * temp in self.color ) {
        temp.hidden = YES;
    }
    if (self.hasReplicatedObjects){
        for (UIImageView * temp in self.replicatedObjectsB ) {
            temp.hidden = YES;
        }
    }

    self.reveal1.hidden = YES;
    self.reveal2.hidden = YES;
    self.reveal3.hidden = YES;
    self.bg1.hidden = NO;
    self.bg2.hidden = NO;
    self.bg3.hidden = NO;
    
    self.puzzleTimer.currentCount = self.numberOfHiddenObjects;
    
    self.puzzleTimer.delegate = self;

    NSError * err;
    NSURL * url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Reveal.mp3",[[NSBundle mainBundle] resourcePath]]];
    
    self.musicCounter = 1;
    
    self.revealPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    [self.revealPlayer prepareToPlay];
    url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/1.mp3",[[NSBundle mainBundle] resourcePath]]];
    self.musicCounter++;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    [self.player prepareToPlay];
    
    self.randomSet = [self generateRandomArrayOf:self.numberOfHiddenObjects from:self.bwSquare.count];

 
    for (NSNumber * num in self.randomSet){
        PulsingUIView * temp = [self.bwRound objectAtIndex:[num intValue]];
        temp.tag = num.intValue;
        temp.userInteractionEnabled = YES;
        temp.hidden = NO;
        if (self.hasReplicatedObjects){
            for (UIImageView * view in self.replicatedObjectsA) {
                if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width ) {
                    view.hidden = NO;
                    view.tag = num.intValue;
                }
            }
            for (UIImageView * view in self.replicatedObjectsC) {
                if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width ) {
                    view.hidden = YES;
                }
            }

            for (UIImageView * view in self.replicatedObjectsB) {
                if (view.frame.size.height == temp.frame.size.height && view.frame.size.width == temp.frame.size.width ) {
                    view.hidden = YES;

                }
            }
            
        }
        
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [temp addGestureRecognizer:recognizer];
        PulsingUIView * temp2 = [self.bwSquare objectAtIndex:[num intValue]];
        temp2.hidden = YES;
        if (self.hasReplicatedObjects){
            for (UIImageView * view in self.replicatedObjectsA)
                if (view.frame.size.height == temp2.frame.size.height && view.frame.size.width == temp2.frame.size.width ) {
                    view.userInteractionEnabled = YES;
                    view.gestureRecognizers = nil;
                    UITapGestureRecognizer * ttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tempTapCallback:)];
                    [view addGestureRecognizer:ttap];
                }
            for (UIImageView * view in self.replicatedObjectsC) {
                if (view.frame.size.height == temp2.frame.size.height && view.frame.size.width == temp2.frame.size.width ) {
                    view.hidden = YES;
                }
            }
        }
    }

    
}

- (void) startTimer
{
	[self.puzzleTimer startTimer:self.puzzleTime];
}
@end
