//
//  PPRotatingView.h
//  JennyJones
//
//  Created by tommyogp on 26/10/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPRotatingViewDelegate <NSObject>
- (void) didCompleteOneSecond;
@end

@interface PPRotatingView : UIImageView

@property (nonatomic, assign) id <PPRotatingViewDelegate> delegate;
@property float rpm; // round per min

- (void) rotate;
- (void) reset;
@end
