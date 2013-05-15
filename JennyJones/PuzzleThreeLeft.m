//
//  PuzzleThreeLeft.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PuzzleThreeLeft.h"
#import "PPPuzzleThreeViewController.h"

@interface PuzzleThreeLeft ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *BG;

@end

@implementation PuzzleThreeLeft

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.scrollView.contentSize = self.BG.image.size;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle three done"] isEqualToString:@"YES"])
    {
        PPPuzzleThreeViewController *puzzleThree = [self.storyboard instantiateViewControllerWithIdentifier:@"puzzleThree"];
        puzzleThree.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        puzzleThree.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:puzzleThree animated:NO];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	self.scrollView = nil;
	self.BG = nil;
}

@end
