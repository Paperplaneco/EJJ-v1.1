//
//  PPPhysicsUtility.h
//  JennyJones
//
//  Created by Corey Manders on 2/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chipmunk-iPhone/chipmunk.h"

@interface PPPhysicsUtility : NSObject
@property (strong,nonatomic) UIView * effectedBody;
@property (strong) UIView * hostview;
@property (nonatomic)double screenHeight;

-(void) applyForceToEffectedBody;
-(void) resetEffectedBody;
-(void) startPhysicsEngine;
@end
