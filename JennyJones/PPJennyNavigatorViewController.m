//
//  PPJennyNavigatorViewController.m
//  JennyJones
//
//  Created by Corey Manders on 3/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPJennyNavigatorViewController.h"
#import "PPRootView.h"
#import "PPPuzzle10ViewController.h"
#import "HomeViewController.h"
#import "SV01.h"
#import "SV02.h"
#import "SV03.h"
#import "SV04.h"
#import "SV05.h"
#import "SV06.h"
#import "SV07.h"
#import "SV09.h"
#import "SV10.h"
#import "SV12.h"
#import "SV13.h"
#import "SV15.h"
#import "SV16.h"
#import "SV17.h"
#import "SV18.h"
#import "SV19.h"
#import "SV21.h"

@implementation PPJennyNavigatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toolbarHidden = YES;
    
    PPRootView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"text page root"];
    vc.viewControllers = [NSArray arrayWithObjects:
                          @"Home",
                          @"SV01",
                          @"SV02",
                          @"SV03",
                          @"SV04",
                          @"SV05",
                          @"SV06",
                          @"SV07",
                          @"puzzleOneLeft",
                          @"SV09",
                          @"SV10",
                          @"puzzleTwoLeft",
                          @"SV12",
                          @"SV13",
                          @"puzzleThreeLeft",
                          @"SV15",
                          @"SV16",
                          @"SV17",
                          @"SV18",
                          @"SV19",
                          @"puzzleTenLeft",
                          @"SV21",
                          nil];
    [self pushViewController:vc animated:NO];
    
//    SV01 *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SV01"];
//    [self pushViewController:vc animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
