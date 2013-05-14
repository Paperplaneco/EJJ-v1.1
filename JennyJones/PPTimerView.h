//
//  PPTimerView.h
//  JennyJones
//
//  Created by Corey Manders on 14/6/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPTimerView;

@protocol PPTimerViewDelegate <NSObject>

-(void) timerDidExpire:(PPTimerView*)sender;

@end

@interface PPTimerView : UIView

@property (assign) int currentCount;
@property float percent;
@property (assign) id delegate;
@property (assign)float timeTaken;

-(void)startTimer:(float)myTimer;
-(void)stopTimer;

@end
