//
//  NavViewController.m
//  JennyJones
//
//  Created by Zune Moe on 27/2/13.
//  Copyright (c) 2013 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "NavViewController.h"

#define SFX_ON_POS CGPointMake(398,58)
#define SFX_OFF_POS CGPointMake(428,58)
#define READ_ON_POS CGPointMake(784,58)
#define READ_OFF_POS CGPointMake(814,58)

@interface NavViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *Bookmark;
@property (weak, nonatomic) IBOutlet UIImageView *SV01;
@property (weak, nonatomic) IBOutlet UIImageView *SV02;
@property (weak, nonatomic) IBOutlet UIImageView *SV03;
@property (weak, nonatomic) IBOutlet UIImageView *SV03b;
@property (weak, nonatomic) IBOutlet UIImageView *SV03c;
@property (weak, nonatomic) IBOutlet UIImageView *SV04;
@property (weak, nonatomic) IBOutlet UIImageView *SV05;
@property (weak, nonatomic) IBOutlet UIImageView *SV06;
@property (weak, nonatomic) IBOutlet UIImageView *SV07;
@property (weak, nonatomic) IBOutlet UIImageView *SV08;
@property (weak, nonatomic) IBOutlet UIImageView *SV09;
@property (weak, nonatomic) IBOutlet UIImageView *SV10;
@property (weak, nonatomic) IBOutlet UIImageView *SV11;
@property (weak, nonatomic) IBOutlet UIImageView *SV12;
@property (weak, nonatomic) IBOutlet UIImageView *SV13;
@property (weak, nonatomic) IBOutlet UIImageView *SV14;
@property (weak, nonatomic) IBOutlet UIImageView *SV15;
@property (weak, nonatomic) IBOutlet UIImageView *SV16;
@property (weak, nonatomic) IBOutlet UIImageView *SV17;
@property (weak, nonatomic) IBOutlet UIImageView *SV18;
@property (weak, nonatomic) IBOutlet UIImageView *SV19;
@property (weak, nonatomic) IBOutlet UIImageView *SV20;
@property (weak, nonatomic) IBOutlet UIImageView *SV21;
@property (weak, nonatomic) IBOutlet UIImageView *SV22;

@property (weak, nonatomic) IBOutlet UIImageView *SFX;
@property (weak, nonatomic) IBOutlet UIImageView *Readaloud;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSUserDefaults *defaults;

@property BOOL SFXOn;
@property BOOL ReadaloudOn;

@end

@implementation NavViewController

@synthesize defaults = _defaults;
@synthesize SFXOn, ReadaloudOn;

- (IBAction)SFXTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX01 play];
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
	{
		self.SFX.center = SFX_OFF_POS;
		[self.defaults setObject:@"NO" forKey:@"sound effect player"];
		[self.defaults synchronize];
	}
	else
	{
		self.SFX.center = SFX_ON_POS;
		[self.defaults setObject:@"YES" forKey:@"sound effect player"];
		[self.defaults synchronize];
	}
}

- (IBAction)SFXPanned:(UIPanGestureRecognizer *)sender
{
	if ([sender state] == UIGestureRecognizerStateEnded)
	{
		[self.SFX01 play];
		
		if ([sender translationInView:self.view].x > 0)
		{
			self.SFX.center = SFX_OFF_POS;
			[self.defaults setObject:@"NO" forKey:@"sound effect player"];
			[self.defaults synchronize];
		}
		else
		{
			self.SFX.center = SFX_ON_POS;
			[self.defaults setObject:@"YES" forKey:@"sound effect player"];
			[self.defaults synchronize];
		}
	}
}

- (IBAction)ReadaloudTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX01 play];
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
	{
		self.Readaloud.center = READ_OFF_POS;
		[self.defaults setObject:@"NO" forKey:@"read aloud player"];
		[self.defaults synchronize];
	}
	else
	{
		self.Readaloud.center = READ_ON_POS;
		[self.defaults setObject:@"YES" forKey:@"read aloud player"];
		[self.defaults synchronize];
	}
}

- (IBAction)ReadaloudPanned:(UIPanGestureRecognizer *)sender
{
	if ([sender state] == UIGestureRecognizerStateEnded)
    {
		[self.SFX01 play];
		
        if ([sender translationInView:self.view].x > 0)
        {
			self.Readaloud.center = READ_OFF_POS;
			[self.defaults setObject:@"NO" forKey:@"read aloud player"];
			[self.defaults synchronize];
		}
		else
		{
			self.Readaloud.center = READ_ON_POS;
			[self.defaults setObject:@"YES" forKey:@"read aloud player"];
			[self.defaults synchronize];
		}
	}
}

- (IBAction)SV0Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:0];
}

- (IBAction)SV01Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:1];
}

- (IBAction)SV02Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:2];
}

- (IBAction)SV03Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:3];
}

- (IBAction)SV03bSelected:(UITapGestureRecognizer *)sender {
	[self removeNavViewAndFlipToPage:4];
}

- (IBAction)SV03cSelected:(UITapGestureRecognizer *)sender {
	[self removeNavViewAndFlipToPage:5];
}

- (IBAction)SV04Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:6];
}

- (IBAction)SV05Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:7];
}

- (IBAction)SV06Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:8];
}

- (IBAction)SV07Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:9];
}

- (IBAction)SV08Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:10];
}

- (IBAction)SV09Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:11];
}

- (IBAction)SV10Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:12];
}

- (IBAction)SV11Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:13];
}

- (IBAction)SV12Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:14];
}

- (IBAction)SV13Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:15];
}

- (IBAction)SV14Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:16];
}

- (IBAction)SV15Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:17];
}

- (IBAction)SV16Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:18];
}

- (IBAction)SV17Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:19];
}

- (IBAction)SV18Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:20];
}

- (IBAction)SV19Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:21];
}

- (IBAction)SV20Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:22];
}

- (IBAction)SV21Selected:(UITapGestureRecognizer *)sender
{
	[self removeNavViewAndFlipToPage:23];
}

- (IBAction)SV22Selected:(UITapGestureRecognizer *)sender {
	[self removeNavViewAndFlipToPage:24];
}

- (void) removeNavViewAndFlipToPage:(int)pageNumber
{
	[self.defaults setObject:@"NO" forKey:@"nav showing"];
	[self.defaults synchronize];
	
	[self flipToPage:pageNumber];
	
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.view.center = CGPointMake(512, -384);
	} completion:^(BOOL finished) {
		[self.view removeFromSuperview];
	}];
}

- (void) flipToPage:(int) pageNum
{
	[self.defaults setInteger:pageNum forKey:@"user selected page"];
	[self.defaults synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}

- (void) placeBookmark
{
	
	switch ([[self.defaults objectForKey:@"current page"] intValue]) {
		case 1:
			self.Bookmark.center = CGPointMake(self.SV01.center.x + 72, self.SV01.center.y - 62);
			break;
		case 2:
			self.Bookmark.center = CGPointMake(self.SV02.center.x + 72, self.SV02.center.y - 62);
			break;
		case 3:
			self.Bookmark.center = CGPointMake(self.SV03.center.x + 72, self.SV03.center.y - 62);
			break;			
		case 4:
			self.Bookmark.center = CGPointMake(self.SV03b.center.x + 72, self.SV03b.center.y - 62);
			break;
		case 5:
			self.Bookmark.center = CGPointMake(self.SV03c.center.x + 72, self.SV03c.center.y - 62);
			break;
		case 6:
			self.Bookmark.center = CGPointMake(self.SV04.center.x + 72, self.SV04.center.y - 62);
			break;
		case 7:
			self.Bookmark.center = CGPointMake(self.SV05.center.x + 72, self.SV05.center.y - 62);
			break;
		case 8:
			self.Bookmark.center = CGPointMake(self.SV06.center.x + 72, self.SV06.center.y - 62);
			break;
		case 9:
			self.Bookmark.center = CGPointMake(self.SV07.center.x + 72, self.SV07.center.y - 62);
			break;
		case 10:
			self.Bookmark.center = CGPointMake(self.SV08.center.x + 72, self.SV08.center.y - 62);
			break;
		case 11:
			self.Bookmark.center = CGPointMake(self.SV09.center.x + 72, self.SV09.center.y - 62);
			break;
		case 12:
			self.Bookmark.center = CGPointMake(self.SV10.center.x + 72, self.SV10.center.y - 62);
			break;
		case 13:
			self.Bookmark.center = CGPointMake(self.SV11.center.x + 72, self.SV11.center.y - 62);
			break;
		case 14:
			self.Bookmark.center = CGPointMake(self.SV12.center.x + 72, self.SV12.center.y - 62);
			break;
		case 15:
			self.Bookmark.center = CGPointMake(self.SV13.center.x + 72, self.SV13.center.y - 62);
			break;
		case 16:
			self.Bookmark.center = CGPointMake(self.SV14.center.x + 72, self.SV14.center.y - 62);
			break;
		case 17:
			self.Bookmark.center = CGPointMake(self.SV15.center.x + 72, self.SV15.center.y - 62);
			break;
		case 18:
			self.Bookmark.center = CGPointMake(self.SV16.center.x + 72, self.SV16.center.y - 62);
			break;
		case 19:
			self.Bookmark.center = CGPointMake(self.SV17.center.x + 72, self.SV17.center.y - 62);
			break;
		case 20:
			self.Bookmark.center = CGPointMake(self.SV18.center.x + 72, self.SV18.center.y - 62);
			break;
		case 21:
			self.Bookmark.center = CGPointMake(self.SV19.center.x + 72, self.SV19.center.y - 62);
			break;
		case 22:
			self.Bookmark.center = CGPointMake(self.SV20.center.x + 72, self.SV20.center.y - 62);
			break;
		case 23:
			self.Bookmark.center = CGPointMake(self.SV21.center.x + 72, self.SV21.center.y - 62);
			break;
		case 24:
			self.Bookmark.center = CGPointMake(self.SV22.center.x + 72, self.SV22.center.y - 62);
			break;
		default:
			break;
	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.trackedViewName = @"Nav View Controller";
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.defaults = [NSUserDefaults standardUserDefaults];
	
	[self.SFX01 setAudioFile:@"00_switch.mp3"];
	
	self.scrollView.contentSize = CGSizeMake(914, 1555);
	
	if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"])
		self.SFX.center = SFX_ON_POS;
	else
		self.SFX.center = SFX_OFF_POS;
	
	if ([[self.defaults objectForKey:@"read aloud player"] isEqualToString:@"YES"])
		self.Readaloud.center = READ_ON_POS;
	else
		self.Readaloud.center = READ_OFF_POS;
	
	[self placeBookmark];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	self.scrollView = nil;
	self.defaults = nil;
	
	self.SFX01 = nil;
}

- (void)viewDidUnload {
	[self setSV03b:nil];
	[self setSV03c:nil];
	[self setSV22:nil];
	[super viewDidUnload];
}
@end
