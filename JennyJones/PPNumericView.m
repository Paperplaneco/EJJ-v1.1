//
//  PPNumericView.m
//  JennyJones
//
//  Created by tommyogp on 26/10/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPNumericView.h"
#import "PPWatchConfig.h"

@interface PPDigitScrollView : UIScrollView
@property (nonatomic) NSUInteger currentDigit;
@end

@interface PPDigitScrollView(){
    UIImageView *upperDigit;
    UIImageView *lowerDigit;
}
- (void) scroll;
- (UIImage *) imageForDigit:(NSUInteger) digit;
@end

@implementation PPDigitScrollView
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*2);
        
        upperDigit = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   self.contentSize.width,self.contentSize.height/2)];
        
        lowerDigit = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentSize.height/2,
                                                                   self.contentSize.width, self.contentSize.height/2)];
        
        [self addSubview:upperDigit];
        [self addSubview:lowerDigit];
    }
    return self;
}

- (void) setCurrentDigit:(NSUInteger)currentDigit{
    NSAssert( currentDigit < 10, @"currentDigit must be 0-9" );
    
    _currentDigit = currentDigit;
    
    if (upperDigit.image) {
        [self scroll];
    }
    else{
        upperDigit.image = [self imageForDigit:_currentDigit];
    }
}

- (void) scroll{
    lowerDigit.image = [self imageForDigit:_currentDigit];
    upperDigit.image = [self imageForDigit:_currentDigit];
    
    /*
    [UIView animateWithDuration:SCROLLING_DURATION
                     animations:^{
                         [self setContentOffset:CGPointMake(0, self.contentSize.height / 2)];
                     }
                     completion:^(BOOL finished) {                         
                         upperDigit.image = [self imageForDigit:_currentDigit];
                         [self setContentOffset:CGPointZero];
                     }];
     */
}

- (UIImage *) imageForDigit:(NSUInteger) digit{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Countdown_%u.png", digit]];
    NSAssert(image, @"File Not Found");
    return image;
}
@end

#pragma mark -

@interface PPNumericView(){
    PPDigitScrollView *scroll1;
    PPDigitScrollView *scroll2;
}

@end

@implementation PPNumericView

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        CGFloat gap = 4.0;
        CGFloat scrollWidth = (self.frame.size.width - gap)/2;
        
        scroll1 = [[PPDigitScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                      scrollWidth, self.frame.size.height)];
        
        scroll2 = [[PPDigitScrollView alloc] initWithFrame:CGRectMake(scrollWidth + gap, 0,
                                                                      scrollWidth, self.frame.size.height)];
        
        [self addSubview:scroll1];
        [self addSubview:scroll2];
    }
    return self;
}

- (void)setCurrentCount:(NSUInteger)currentCount{
    NSAssert( currentCount < 100, @"startingCount must be 0-99" );
    
    _currentCount = currentCount;
    
    [scroll1 setCurrentDigit:currentCount/10];
    [scroll2 setCurrentDigit:currentCount%10];
}

@end
