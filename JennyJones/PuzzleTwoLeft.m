//
//  PuzzleTwoLeft.m
//  JennyJones
//
//  Created by Zune Moe on 28/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PuzzleTwoLeft.h"
#import "PPPuzzleTwoViewController.h"

@interface PuzzleTwoLeft ()

@end

@implementation PuzzleTwoLeft

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two done"] isEqualToString:@"YES"])
    {
        PPPuzzleTwoViewController *puzzleTwo = [self.storyboard instantiateViewControllerWithIdentifier:@"puzzleTwo"];
        puzzleTwo.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        puzzleTwo.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:puzzleTwo animated:NO];
    }
}

@end
