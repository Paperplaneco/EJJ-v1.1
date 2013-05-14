//
//  HomeViewController.h
//  JennyJones
//
//  Created by Zune Moe on 9/1/13.
//  Copyright (c) 2013 Paperplane Pilots Pte Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPAnimatingViewController.h"
#import "OBShapedButton.h"

@interface HomeViewController : PPAnimatingViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;
//@property (weak, nonatomic) IBOutlet UIImageView *About;
@property (weak, nonatomic) IBOutlet OBShapedButton *About;
//@property (weak, nonatomic) IBOutlet UIImageView *StartReading;
@property (weak, nonatomic) IBOutlet OBShapedButton *StartReading;
@property (weak, nonatomic) IBOutlet UIImageView *Gramophone;
@property (weak, nonatomic) IBOutlet UIImageView *RibbonBase;
//@property (weak, nonatomic) IBOutlet UIImageView *Note;
@property (weak, nonatomic) IBOutlet OBShapedButton *Note;
@property (weak, nonatomic) IBOutlet OBShapedButton *MiaoHelp;




@property (weak, nonatomic) IBOutlet UIImageView *MiaoHelp_Tapped;
@property (weak, nonatomic) IBOutlet UIImageView *MedalSilver;
@property (weak, nonatomic) IBOutlet UIImageView *MedalGold;
@property (weak, nonatomic) IBOutlet UIImageView *SFX_On;
@property (weak, nonatomic) IBOutlet UIImageView *SFX_Off;
@property (weak, nonatomic) IBOutlet UIImageView *Read_ON;
@property (weak, nonatomic) IBOutlet UIImageView *Read_OFF;

@property (weak, nonatomic) IBOutlet UIImageView *About_BG;
@property (weak, nonatomic) IBOutlet UIImageView *About_Home;
@property (weak, nonatomic) IBOutlet UIImageView *About_Facebook;
@property (weak, nonatomic) IBOutlet UIImageView *About_Rate;
@property (weak, nonatomic) IBOutlet UIImageView *About_More;

@property (weak, nonatomic) IBOutlet UIImageView *PZL_BG;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_08BW;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_08COL;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_11BW;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_11COL;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_14BW;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_14COL;
@property (weak, nonatomic) IBOutlet UIImageView *PZL20_BW;
@property (weak, nonatomic) IBOutlet UIImageView *PZL20_COL;
@property (weak, nonatomic) IBOutlet UIImageView *PZL_Reset;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *Help_Frame;
@property (weak, nonatomic) IBOutlet UIImageView *Notepopover;
@property (weak, nonatomic) IBOutlet UIImageView *DimBackground;


@end
