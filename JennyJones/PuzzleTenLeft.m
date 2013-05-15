//
//  PuzzleTenLeft.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PuzzleTenLeft.h"
#import "PPPuzzle10ViewController.h"

@interface PuzzleTenLeft ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PuzzleTenLeft

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.scrollView.contentSize = CGSizeMake(4869, 768);
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle ten done"] isEqualToString:@"YES"])
    {
        PPPuzzle10ViewController *puzzleTen = [self.storyboard instantiateViewControllerWithIdentifier:@"puzzleTen"];
        puzzleTen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        puzzleTen.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:puzzleTen animated:NO];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	self.scrollView = nil;
}

@end
