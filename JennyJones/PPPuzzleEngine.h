//
//  PPPuzzleEngine.h
//  JennyJones
//
//  Created by Corey Manders on 10/7/12.
//
//

// How to use
//------------
//
// 1) in the parent view controller init a PPPuzzleEngine with black and white and color outlets
// 2) set the numberOfHiddenObjects
// 3) set the numberOfMusicFiles
// 4) set the hostView to be the view of the parent view controller
// 5) call the startEngine method

#import <Foundation/Foundation.h>
#import "PPWatchView.h"

@protocol PPPuzzleEngineDelegate

-(void) puzzleCompleted:(BOOL )complete;

@end

@interface PPPuzzleEngine : NSObject

@property int numberOfHiddenObjects;
@property int numberOfMusicFiles;
@property (strong,nonatomic) UIView * hostView;
@property (strong, nonatomic) PPWatchView * puzzleTimer;
@property (assign) float puzzleTime;
@property (assign) id delegate;
@property  CAEmitterLayer *emitter2;
@property BOOL hasReplicatedObjects;
@property NSArray * replicatedObjectsA;
@property NSArray * replicatedObjectsB;
@property NSArray * replicatedObjectsC;
@property (strong)NSArray * additionalImages;
@property (strong)NSArray * additionalReveal;

-(id) initWithBWObjects:(NSArray *)ibwRound color:(NSArray*)icolor bwSquare:(NSArray*)ibwSquare
             backgound1:(UIImageView*)ibg1 background2:(UIImageView*)ibg2 background3:(UIImageView*)ibg3
                reveal1:(UIImageView*)ireveal1 reveal2:(UIImageView*)ireveal2  reveal3:(UIImageView*)ireveal3;

-(void) startEngine;
-(void) reset;
-(void) pulseObjects;
-(void) startTimer;

-(UIView *)giveHintUsingEmitter;
-(UIView*) giveHintUsingEmitterWithContentOffset:(float)x;


@end
