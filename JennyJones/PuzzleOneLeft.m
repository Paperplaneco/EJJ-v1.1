//
//  PuzzleOneLeft.m
//  JennyJones
//
//  Created by Zune Moe on 30/1/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PuzzleOneLeft.h"
#import "PPPuzzleOneViewController.h"

@interface PuzzleOneLeft ()

@end

@implementation PuzzleOneLeft

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle one done"] isEqualToString:@"YES"])
    {
        PPPuzzleOneViewController *puzzleOne = [self.storyboard instantiateViewControllerWithIdentifier:@"puzzleOne"];
        puzzleOne.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        puzzleOne.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:puzzleOne animated:NO];
    }
}

@end
