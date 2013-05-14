//
//  PPHalfPageImageViewController.h
//  JennyJones
//
//  Created by Corey Manders on 1/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LEFT 0
#define RIGHT 1
@interface PPHalfPageImageViewController : UIViewController
@property (strong) UIImage * image;
@property (assign) BOOL showPageCurl;

-(id)initWithImage:(UIImage *)image side:(int)side;

+ (UIImage*)halfPageImageWithImage:(UIImage*)image pageSide:(int)page;

@end
