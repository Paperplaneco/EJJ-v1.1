//
//  PPViewController.h
//  JennyJones
//
//  Created by Corey Manders on 11/6/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_BG_bw;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_001b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_001a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_002b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_002a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_003a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_003b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_004b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_004a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_005b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_005a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_006b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_006a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_007b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_007a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_008b;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_008a;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_009b;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *color_collection;
@property (weak, nonatomic) IBOutlet UIImageView *PZL01_009a;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bw_collection;

@end
