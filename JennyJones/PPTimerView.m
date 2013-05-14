//
//  PPTimerView.m
//  JennyJones
//
//  Created by Corey Manders on 14/6/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPTimerView.h"


@interface PPTimerView()
@property UIImage * fg_image;
@property UIImage * bg_image;
@property CGContextRef  context;
@property (strong,nonatomic) NSTimer * timer;
@property (assign, nonatomic) float countdownTimer;
@property (assign) float totalTime;


@end

@implementation PPTimerView
@synthesize context = _context;
@synthesize fg_image = _fg_image;
@synthesize bg_image = _bg_image;
@synthesize currentCount = _currentCount;
@synthesize percent = _percent;
@synthesize countdownTimer = _countdownTimer;
@synthesize timer = _timer;
@synthesize totalTime = _totalTime;
@synthesize delegate = _delegate;

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) timerCallback
{
    self.countdownTimer -=0.1;
    self.percent = self.countdownTimer/self.totalTime;
    self.timeTaken +=0.1;
    
    if (self.countdownTimer <=0.0){
        [self.timer  invalidate];
        self.timer = nil;
        if ([self.delegate respondsToSelector:@selector(timerDidExpire:)])
             [self.delegate timerDidExpire:self];
    }
    [self setNeedsDisplay];
 
}

-(void)startTimer:(float)myTimer
{
    self.countdownTimer=myTimer;
    self.totalTime = myTimer;
    self.timeTaken = 0.0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil; 
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                  
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    float scalingFactor = 0.95;
    
    if (!self.bg_image){
        CGSize newImageSize = CGSizeMake(rect.size.width*scalingFactor, rect.size.width*scalingFactor);
        self.bg_image = [self imageWithImage:[UIImage imageNamed:@"IndicatorBG.png"] scaledToSize:newImageSize];
        if (!self.bg_image)NSLog(@"BG image didn't load");
    }
    self.context = UIGraphicsGetCurrentContext();
    CGPoint myCenter = CGPointMake(rect.origin.x + rect.size.width/2.0, rect.origin.y+rect.size.width/2.0);
    

    float offsetW =(rect.size.width-self.bg_image.size.width)/2.0;
    float offsetH =(rect.size.width-self.bg_image.size.width)/2.0;// rect.size.height*(1.0-scalingFactor)/2.0;
    CGContextSetShadowWithColor(self.context, CGSizeMake(4,-5), 5.0, [UIColor colorWithRed:0.0 green:0.0 
                                                                                      blue:0.0 alpha:0.3].CGColor);
     [self.bg_image drawAtPoint:CGPointMake(offsetW, offsetW)];
    scalingFactor = 0.8;
 
    offsetW = rect.size.width*(1.0-scalingFactor)/2.0;
    offsetH = rect.size.height*(1.0-scalingFactor)/2.0;
    if (!self.fg_image){
        CGSize newImageSize = CGSizeMake(rect.size.width*scalingFactor, rect.size.width*scalingFactor);
        self.fg_image = [self imageWithImage:[UIImage imageNamed:@"IndicatorFG.png"] scaledToSize:newImageSize] ;
    }
 
    NSString * counterText = [NSString stringWithFormat:@"%.2d",self.currentCount];
  
    UIFont* jennyFont = [UIFont fontWithName:@"Clarendon BT" size:36];
    CGSize strsize = [counterText sizeWithFont:jennyFont];
    if (!jennyFont)NSLog(@"FONT PROBLEM");
    CGPoint textPoint = myCenter;
    
    textPoint.x = textPoint.x-strsize.width/2.0;
    textPoint.y = textPoint.y- strsize.height/2.0;
 
    CGContextMoveToPoint(self.context, myCenter.x, 0.0);
    CGContextSetLineWidth(self.context, 20.0);
    
    CGContextSetStrokeColorWithColor(self.context, [UIColor blueColor].CGColor);
    CGFloat radius = rect.size.width / 2.5;
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (1.0-self.percent)  *( 2 * (float)M_PI)  - ((float)M_PI / 2);//startAngle;
  
    CGContextMoveToPoint(self.context, myCenter.x, myCenter.y-radius);
    CGContextAddArc(self.context, myCenter.x, myCenter.y, radius, startAngle, endAngle, 0);

    CGContextSetShadowWithColor(self.context, CGSizeMake(0,0), 5.0, [UIColor colorWithRed:0.0 green:0.0 
                                                                                     blue:1.0 alpha:0.3].CGColor);
    CGContextStrokePath(self.context);
    CGContextSetShadowWithColor(self.context, CGSizeMake(4,-5), 5.0, [UIColor colorWithRed:0.0 green:0.0 
                                                                                      blue:0.0 alpha:0.3].CGColor);
    [self.fg_image drawAtPoint:CGPointMake(offsetW, offsetW)];
    CGContextSetFillColorWithColor(self.context, [UIColor whiteColor].CGColor);
    CGContextSetShadowWithColor(self.context, CGSizeMake(2,-3), 3.0, [UIColor colorWithRed:0.0 green:0.0 
                                                                                      blue:0.0 alpha:0.3].CGColor);
    [counterText drawAtPoint:textPoint withFont:jennyFont ] ;
    
    
}


@end
