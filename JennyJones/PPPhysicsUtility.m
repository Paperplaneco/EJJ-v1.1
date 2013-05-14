//
//  PPPhysicsUtility.m
//  JennyJones
//
//  Created by Corey Manders on 2/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPPhysicsUtility.h"
#define ARC4RANDOM_MAX      0x100000000

@interface PPPhysicsUtility(){

}
@property (strong,nonatomic) UIView * hiddenObject;
@end

@implementation PPPhysicsUtility

@synthesize effectedBody = _effectedBody;
@synthesize hostview = _hostview;
@synthesize screenHeight = _screenHeight;
@synthesize hiddenObject = _hiddenObject;

cpSpace *space;
cpBody *miaowStatic;
cpBody *miaowSpringy;
float cscreenHeight;
float miaoX, miaoY;
float rotRand;

-(void)setEffectedBody:(UIView *)effectedBody
{
    _effectedBody = effectedBody;
    self.hiddenObject = [[UIView alloc] init];
    self.hiddenObject.frame = _effectedBody.frame;
    self.hiddenObject.hidden = YES;
    self.hiddenObject.center = effectedBody.center;
    miaoX = effectedBody.center.x;
    miaoY = effectedBody.center.y;
}

-(void)setScreenHeight:(double)screenHeight
{
    _screenHeight = screenHeight;
    cscreenHeight = screenHeight;
}

-(void)startPhysicsEngine{
    [self setupChipmunk];
}

-(void)resetEffectedBody{
    cpBodyResetForces(miaowSpringy);
    miaowSpringy->p = cpv(miaoX,cscreenHeight-miaoY);
    miaowSpringy->v = cpv(0.0f, 0.0f);
    miaowSpringy->a = 0.0f;
    miaowSpringy->w = 0.0f;
    miaowSpringy->t = 0.0f;
}

void updateShape(void *ptr) {
    
    // Get our shape
    cpShape *shape = (cpShape*)ptr;
    
    // Make sure everything is as expected or tip & exit
    if(shape == nil || shape->body == nil || shape->data == nil) {
        NSLog(@"Unexpected shape please debug here...");
        return;
    }
    
    
    // Lastly checks if the object is an UIView of any kind
    // and update its position accordingly
    if([(__bridge UIView*)shape->data isKindOfClass:[UIView class]]) {
        UIImageView * temp = (__bridge UIImageView*)shape->data;
        temp.center = CGPointMake(shape->body->p.x,cscreenHeight  -shape->body->p.y);
        temp.transform = CGAffineTransformMakeRotation(cpBodyGetAngle(shape->body)*rotRand);
        // temp.transform = CGAffineTransformMakeRotation();
        [(__bridge UIView *)shape->data setCenter:CGPointMake(shape->body->p.x,cscreenHeight  -shape->body->p.y)];
		//NSLog(@"effected body center = (%g,%g)",temp.center.x,temp.center.y);
        
    }
    else
        NSLog(@"The shape data wasn't updateable using this code.");
}

// Called at each "frame" of the simulation

- (void)tick:(NSTimer *)timer {
    
    // Tell Chipmunk to take another "step" in the simulation
    // self.deviceMotion = self.motionManager.deviceMotion;
    // self.attitude = self.deviceMotion.attitude;
    // space->gravity = cpv(self.attitude.roll*100.0, self.attitude.pitch*-200);
    cpSpaceStep(space, 1.0f/60.0f);
    cpSpaceEachShape(space, &updateShape, nil);
    
    
    //NSLog(@"roll = %g pitch = %g ",self.attitude.roll, self.attitude.pitch);
}

-(void)applyForceToEffectedBody{
    
    double val = ((double)arc4random() / ARC4RANDOM_MAX)*100;
    double val2 = sqrt(100.0*100.0 - val*val);
    float rotVal = 5.0;
    rotRand = ((double)arc4random() / ARC4RANDOM_MAX)*rotVal-rotVal/2.0;
    
    double val3  = ((double)arc4random() / ARC4RANDOM_MAX)*1000;
    double val4 = sqrt(1000.0*1000.0 - val3*val3);
    
    cpBodyApplyImpulse(miaowSpringy, cpv(val,val2), cpv(100.0f,00.0f));
    cpBodyApplyForce(miaowSpringy, cpv(val3,val4) , cpv(10,10));
    // miaowSpringy->v = cpv(100.0f, 100.0f);
  
}

- (void)setupChipmunk {
    
    // Start chipmunk
    cpInitChipmunk();
    
    // Create a space object
    space = cpSpaceNew();
    
    // Define a gravity vector
    
    space->gravity = cpv(0, 0);
    
    // Creates a timer firing at a constant interval (desired frame rate)
    // Note that if you are using too much CPU the real frame rate will be lower and
    // the timer might fire before the last frame was complete.
    // There are techniques you can use to avoid this but I won't approach them here.
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    // new springy ball
    CGFloat momentHead = cpMomentForBox(1.0, 1.0, 1050.0) ;
    
    //  miaowSpringy = cpBodyNew(0.1, cpMomentForCircle( 0.1, 0.0, 20.0, cpvzero ) );
    miaowSpringy = cpBodyNew(0.15, momentHead );
    miaowSpringy->p = cpv(miaoX,cscreenHeight-miaoY);
    miaowStatic = cpBodyNew(INFINITY,INFINITY);
    miaowStatic->p = cpv(miaoX,cscreenHeight-miaoY);
    
    cpSpaceAddBody(space, miaowSpringy);
    
    // springs for head bounciness
    cpConstraint *newSpringConstraint = cpDampedSpringNew(miaowSpringy, miaowStatic, cpvzero, cpvzero, 00.0f, 200.0f, 2.0f);
    cpConstraint *rotaryConstraint = cpDampedRotarySpringNew (miaowSpringy, miaowStatic, 1.0, 80, 2.0);
    
    cpSpaceAddConstraint(space, newSpringConstraint);
    cpSpaceAddConstraint(space, rotaryConstraint);
    
    cpShape *springShape = cpCircleShapeNew(miaowSpringy, 20.0, cpvzero);
    springShape->data = (__bridge void*)self.effectedBody;
    springShape->collision_type = 1; //
    springShape->e = 1.0; // Elasticity
    springShape->u = 0.0; // Friction
    cpSpaceAddShape(space, springShape);
    
    cpShape *staticShape = cpCircleShapeNew(miaowStatic, 00.0, cpvzero);
    staticShape->data = (__bridge void*)self.hiddenObject;
    staticShape->collision_type = 0; //
    staticShape->e = 1.0; // Elasticity
    staticShape->u = 0.0; // Friction
    
    space->enableContactGraph = YES;
    cpSpaceSetIterations(space, 10);
    
}
@end
