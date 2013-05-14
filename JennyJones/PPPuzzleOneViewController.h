//
//  PPPuzzleOneViewController.h
//  JennyJones
//
//  Created by Corey Manders on 10/7/12.

//

#import <UIKit/UIKit.h>
#import "PPWatchView.h"
#import "PulsingUIView.h"
#import "GAITrackedViewController.h"

@interface PPPuzzleOneViewController : GAITrackedViewController
@property int pageNumber;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_Reveal;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_BG;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_01a;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_01b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_02a;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_02b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_03a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_03b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_04a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_04b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_05a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_05b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_06a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_06b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_07a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_07b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_09a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_09b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_10a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_10b;
@property (weak, nonatomic) IBOutlet PulsingUIView *PZL06_11a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_11b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_06c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_07c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_09c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_12c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_01c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_02c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_03c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_10c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_05c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_04c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_11c;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_12a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_12b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_miaow02b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL06_miaow02a;
-(void)reset;
@end
