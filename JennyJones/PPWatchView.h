//
//  PPWatchView.h
//  JennyJones
//
//  Created by tommyogp on 26/10/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class PPWatchView;
@protocol PPWatchViewDelegate <NSObject>
-(void)timerDidExpire:(PPWatchView *)sender;
@end

@interface PPWatchView : UIView

@property (nonatomic, assign) id <PPWatchViewDelegate> delegate;
@property (nonatomic) NSUInteger currentCount; // item

@property float percent;
@property float timeTaken; // seconds

- (id)initWatchView;
- (void)startTimer:(float) interval;
- (void)stopTimer;

@end
