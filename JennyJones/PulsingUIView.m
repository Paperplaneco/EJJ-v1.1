//
//  PulsingUIView.m
//  monkeys_v0
//


#import "PulsingUIView.h"
#import <QuartzCore/QuartzCore.h>
#define EXPANSION 0.0
#define PULSE_TIME 2.5


// color for the pulse
#define RED 0.0
#define GREEN 0.0
#define BLUE 1.0
#define ALPHA 0.8

#define PULSE_OPACITY 1.0
#define PULSE_RADIUS 10.0

//#define ALPHA 1.0

//#define PULSE_OPACITY 1.0
//#define PULSE_RADIUS 10.0
@interface PulsingUIView()

@property (assign) int stage;
@property (assign) CGRect originaSize;
@property (strong, nonatomic) NSTimer * timer;

@end

@implementation PulsingUIView
@synthesize stage = _stage;
@synthesize originaSize = _originaSize;
@synthesize timer = _timer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)shadowGrow {
    CABasicAnimation *shadowGrow = [CABasicAnimation animationWithKeyPath:@"shadowRadius" ];
    shadowGrow.delegate = self;
    [shadowGrow setFromValue:[NSNumber numberWithFloat:0.0]];
    [shadowGrow setToValue:[NSNumber numberWithFloat:PULSE_RADIUS]];
    [shadowGrow setDuration:PULSE_TIME/2.0];
    shadowGrow.autoreverses = YES;
    
    /*
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.x" ];
    move.delegate = self;
    [move setFromValue:[NSNumber numberWithFloat:0]];
    [move setToValue:[NSNumber numberWithFloat:50]];
    [move setDuration:1.0f];
    move.autoreverses = YES;
     */
    
    //Add animation to a specific element's layer. Must be called after the element is displayed.
    [[self layer] addAnimation:shadowGrow forKey:@"shadowRadius"];
    //[[button layer] addAnimation:move forKey:@"transform.translation.x"];
}

-(void) doAnimation{
    if (self.stage == 0){
        CGRect temp = self.bounds;
        temp.size.width *= EXPANSION;
        temp.size.height *= EXPANSION;
        [UIView animateWithDuration:PULSE_TIME /2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
           // self.bounds  = temp;
            self.layer.shadowOpacity = 0.25;
            self.layer.shadowRadius = PULSE_RADIUS;
           
        }completion:nil];
        self.stage = 1;
    }
    
    else {
        CGRect temp = self.bounds;
        temp.size.width *= (1.0/EXPANSION);

        
        [UIView animateWithDuration:PULSE_TIME/2.0 delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
           // self.bounds = temp;
            
            self.layer.shadowOpacity = PULSE_OPACITY;
            
            self.layer.shadowRadius = PULSE_RADIUS;
            
        }completion:^(BOOL finished){
            NSLog(@"should stop pulsing");
            [self stopPulsing];}];
        self.stage = 0;
    }
}

-(void) pulse{
    self.originaSize = self.bounds;
    self.layer.shadowOpacity = PULSE_OPACITY;
    self.layer.shadowRadius = 0.0;

    self.layer.shadowColor = [UIColor colorWithRed:RED green:GREEN 
                                              blue:BLUE alpha:ALPHA].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:PULSE_TIME target:self selector:@selector(shadowGrow) userInfo:nil repeats:NO];

}
-(void) stopPulsing{
    [self.timer invalidate];
    self.timer = nil;

    self.layer.shadowOpacity = 0.0;
    self.layer.shadowRadius = 0.0;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
