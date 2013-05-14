//
//  PPRotatingView.m
//  JennyJones
//
//  Created by tommyogp on 26/10/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPRotatingView.h"
#import "PPWatchConfig.h"

#define DEGREE_TO_RAD(deg) ( ( deg*M_PI ) / 180.0 )

#ifdef DEBUG_MODE
// boost up
    #define DURATION 0.1
    #define ONE_SECOND_COUNT 1
#else
    #define DURATION 0.1
    #define ONE_SECOND_COUNT ((NSUInteger) (1/DURATION))
#endif

@interface PPRotatingView(){
    NSTimer *timer;
    NSUInteger secCount;
}

@end

@implementation PPRotatingView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        secCount = 0;
    }
    return self;
}

- (void) rotate{
    // NOTE: timer must be added to run loop,
    // otherwise it'll be paused by scroll view
    timer = [NSTimer timerWithTimeInterval:DURATION
                                    target:self
                                  selector:@selector(timerCallback)
                                  userInfo:nil
                                   repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void) reset{
    [timer invalidate];
    timer = nil;
    secCount = 0;
    self.transform = CGAffineTransformIdentity;
}

#pragma mark -
- (void) timerCallback{
    secCount = (secCount + 1) % ONE_SECOND_COUNT;
    
#ifdef DEBUG_MODE
    NSLog(@"secCount: %i",secCount);
#endif
    
    if (secCount == 0) {
#ifdef DEBUG_MODE
        NSLog(@"didCompleteOneSecond");
#endif
        [_delegate didCompleteOneSecond];
    }
    
    self.transform = CGAffineTransformRotate(self.transform, (_rpm * 2 * M_PI) / 600);
}

@end
