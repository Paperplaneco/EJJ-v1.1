//
//  HomeViewController.m
//  JennyJones
//
//  Created by Zune Moe on 9/1/13.
//  Copyright (c) 2013 Paperplane Pilots Pte Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "PPRootView.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet OBShapedButton *popoverClose;
@property (weak, nonatomic) IBOutlet UIImageView *warningReset;
@property (weak, nonatomic) IBOutlet OBShapedButton *warningResetNo;
@property (weak, nonatomic) IBOutlet OBShapedButton *warningResetYes;
@property (weak, nonatomic) IBOutlet UIImageView *babyGate;
@property (weak, nonatomic) IBOutlet UIImageView *thirdCircle;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *otherCircles;

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *pageViewsString;

-(void) loadVisiblePages;
-(void) loadPage: (NSInteger) page;
-(void) purgePage: (NSInteger) page;
-(void) imageAlpha: (float) alpha;
-(void) imageUserInteractionEnabled: (BOOL) interaction;

@end

@implementation HomeViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;
@synthesize pageViewsString = _pageViewsString;

- (IBAction)closePopover:(UITapGestureRecognizer *)sender {
	self.About_BG.hidden = YES;
    self.About_Facebook.hidden = YES;
    self.About_Home.hidden = YES;
    self.About_More.hidden = YES;
    self.About_Rate.hidden = YES;
    
    self.PZL_BG.hidden = YES;
    self.PZL_08BW.hidden = YES;
    self.PZL_08COL.hidden = YES;
    self.PZL_11BW.hidden = YES;
    self.PZL_11COL.hidden = YES;
    self.PZL_14BW.hidden = YES;
    self.PZL_14COL.hidden = YES;
    self.PZL20_BW.hidden = YES;
    self.PZL20_COL.hidden = YES;
    self.PZL_Reset.hidden = YES;
    
    self.Help_Frame.hidden = YES;
    self.pageControl.hidden = YES;
    self.scrollView.hidden = YES;
    
    self.Notepopover.hidden = YES;
	
    [self imageAlpha:1.0];
    [self imageUserInteractionEnabled: YES];
    self.DimBackground.hidden = YES;
    self.DimBackground.alpha = 0.0;
	
	self.popoverClose.hidden = YES;
}

- (void) revealPopoverCloseButton:(CGRect) rect
{
	self.popoverClose.center = CGPointMake(CGRectGetMaxX(rect)-25, CGRectGetMinY(rect)+40);
	self.popoverClose.hidden = NO;
}

- (IBAction)startReading:(UITapGestureRecognizer *)sender
{
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX05 play];
	
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"currentPage"];
}

- (IBAction)thirdCircleTapped:(UITapGestureRecognizer *)sender {
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX04 play];
	
    self.About_BG.hidden = NO;
    self.About_Facebook.hidden = NO;
    self.About_Home.hidden = NO;
    self.About_More.hidden = NO;
    self.About_Rate.hidden = NO;
	
	self.About_BG.userInteractionEnabled = YES;
    
    [self imageAlpha:0.4];
    [self imageUserInteractionEnabled: NO];
	
	[self revealPopoverCloseButton:self.About_BG.frame];
	
	[self hideBabyGate:YES];
}

- (IBAction)otherCirclesTapped:(UITapGestureRecognizer *)sender {
	[self hideBabyGate:YES];
	[self imageAlpha:1.0];
	[self imageUserInteractionEnabled:YES];
	self.DimBackground.hidden = YES;
    self.DimBackground.alpha = 0.0;
}

- (IBAction)aboutPage:(UITapGestureRecognizer *)sender
{
	[self hideBabyGate:NO];
	[self imageAlpha:0.4];
	[self imageUserInteractionEnabled:NO];
}

- (void) hideBabyGate: (BOOL) show
{
	self.babyGate.hidden = show;
	self.thirdCircle.hidden = show;
	
	for (UIImageView *image in self.otherCircles) {
		image.hidden = show;
	}
}

- (IBAction)readAloudTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX06 play];
	
    self.Read_ON.hidden = YES;
    self.Read_OFF.hidden = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"read aloud player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)readAloudPanned:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        if ([sender translationInView:self.view].x > 0)
        {
			[self.SFX06 play];
			
            self.Read_ON.hidden = YES;
            self.Read_OFF.hidden = NO;
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"read aloud player"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (IBAction)readAloudOffTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX06 play];
	
    self.Read_ON.hidden = NO;
    self.Read_OFF.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"read aloud player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)readAloudOffPanned:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        if ([sender translationInView:self.view].x < 0)
        {
			[self.SFX06 play];
			
            self.Read_ON.hidden = NO;
            self.Read_OFF.hidden = YES;
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"read aloud player"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (IBAction)musicSFXOnTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX06 play];
	
    self.SFX_On.hidden = YES;
    self.SFX_Off.hidden = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"sound effect player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.voiceOverPlayer stop];
}

- (IBAction)musicSFXOnPanned:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        if ([sender translationInView:self.view].x > 0)
        {
			[self.SFX06 play];
			
            self.SFX_On.hidden = YES;
            self.SFX_Off.hidden = NO;
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"sound effect player"];
            [[NSUserDefaults standardUserDefaults] synchronize];
			
			[self.voiceOverPlayer stop];
        }
    }
}

- (IBAction)musicSFXOffTapped:(UITapGestureRecognizer *)sender
{
	[self.SFX06 play];
	
    self.SFX_On.hidden = NO;
    self.SFX_Off.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"sound effect player"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.voiceOverPlayer play];
}

- (IBAction)musicSFXOffPanned:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateEnded)
    {        
        if ([sender translationInView:self.view].x < 0)
        {
			[self.SFX06 play];
			
            self.SFX_On.hidden = NO;
            self.SFX_Off.hidden = YES;
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"sound effect player"];
            [[NSUserDefaults standardUserDefaults] synchronize];
			
			[self.voiceOverPlayer play];
        }
    }
}

- (IBAction)puzzleStatusTapped:(UITapGestureRecognizer *)sender
{
	self.PZL_BG.center = CGPointMake(508, 376);
	self.PZL_08BW.center = CGPointMake(156, 348);
	self.PZL_08COL.center = CGPointMake(156, 348);
	self.PZL_11BW.center = CGPointMake(365, 355);
	self.PZL_11COL.center = CGPointMake(365, 355);
	self.PZL_14BW.center = CGPointMake(722, 350);
	self.PZL_14COL.center = CGPointMake(722, 350);
	self.PZL20_BW.center = CGPointMake(512, 556);
	self.PZL20_COL.center = CGPointMake(512, 556);
	self.PZL_Reset.center = CGPointMake(904, 646);
	
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
	
    [self imageAlpha:0.4];
    [self imageUserInteractionEnabled: NO];
    
    self.PZL_BG.hidden = NO;
    self.PZL_Reset.hidden = NO;
	
	[self revealPopoverCloseButton:self.PZL_BG.frame];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle one done"] isEqualToString:@"YES"]) {
        self.PZL_08BW.hidden = YES;
        self.PZL_08COL.hidden = NO;
    }else {
        self.PZL_08BW.hidden = NO;
        self.PZL_08COL.hidden = YES;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two done"] isEqualToString:@"YES"]) {
        self.PZL_11BW.hidden = YES;
        self.PZL_11COL.hidden = NO;
    }else {
        self.PZL_11BW.hidden = NO;
        self.PZL_11COL.hidden = YES;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle three done"] isEqualToString:@"YES"]) {
        self.PZL_14BW.hidden = YES;
        self.PZL_14COL.hidden = NO;
    }else {
        self.PZL_14BW.hidden = NO;
        self.PZL_14COL.hidden = YES;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle ten done"] isEqualToString:@"YES"]) {
        self.PZL20_BW.hidden = YES;
        self.PZL20_COL.hidden = NO;
    }else {
        self.PZL20_BW.hidden = NO;
        self.PZL20_COL.hidden = YES;
    }
}

- (IBAction) helpTapped:(UITapGestureRecognizer *)sender
{
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX02 play];
	
    self.Help_Frame.hidden = NO;
    self.pageControl.hidden = NO;
    self.scrollView.hidden = NO;
	
	self.Help_Frame.userInteractionEnabled = YES;
    
    [self imageAlpha:0.4];
    [self imageUserInteractionEnabled: NO];
	
	[self revealPopoverCloseButton:self.Help_Frame.frame];
}

- (IBAction)visitUsTapped:(UITapGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://www.paperplaneco.com"]];
}

- (IBAction)beAFanTapped:(UITapGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://m.facebook.com/?_rdr#!/paperplanepilots?__user=0"]];
}

- (IBAction)rateUsTapped:(UITapGestureRecognizer *)sender
{
    NSString *REVIEW_URL = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=633392398&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:REVIEW_URL]];
}

- (IBAction)moreAppsTapped:(UITapGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://itunes.apple.com/gb/artist/paperplaneco/id633392398"]];
}

- (IBAction)puzzle8Tapped:(UITapGestureRecognizer *)sender
{
	[[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"user selected page"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}

- (IBAction)puzzle11Tapped:(UITapGestureRecognizer *)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:13 forKey:@"user selected page"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}
- (IBAction)puzzle14Tapped:(UITapGestureRecognizer *)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:16 forKey:@"user selected page"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}

- (IBAction)puzzle20Tapped:(UITapGestureRecognizer *)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:22 forKey:@"user selected page"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Page" object:@"user selected page"];
}

- (IBAction)puzzleResetTapped:(UITapGestureRecognizer *)sender
{
	[self puzzleResetImageInteraction:NO];
}

- (IBAction)puzzleResetNoTapped:(UITapGestureRecognizer *)sender {
	[self puzzleResetImageInteraction:YES];
}

- (void) puzzleResetImageInteraction:(BOOL) interaction
{
	self.PZL_11BW.userInteractionEnabled = interaction;
	self.PZL_11COL.userInteractionEnabled = interaction;
	self.PZL_08BW.userInteractionEnabled = interaction;
	self.PZL_08COL.userInteractionEnabled = interaction;
	self.PZL_14BW.userInteractionEnabled = interaction;
	self.PZL_14COL.userInteractionEnabled = interaction;
	self.PZL20_BW.userInteractionEnabled = interaction;
	self.PZL20_COL.userInteractionEnabled = interaction;
	
	self.warningReset.hidden = interaction;
	self.warningResetNo.hidden = interaction;
	self.warningResetYes.hidden = interaction;
	self.popoverClose.userInteractionEnabled = interaction;
}

- (IBAction)puzzleResetYesTapped:(UITapGestureRecognizer *)sender {
	NSLog(@"should reset puzzle here");
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle one done"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle two done"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle three done"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle ten done"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.PZL_08BW.hidden = NO;
    self.PZL_08COL.hidden = YES;
    self.PZL_11BW.hidden = NO;
    self.PZL_11COL.hidden = YES;
    self.PZL_14BW.hidden = NO;
    self.PZL_14COL.hidden = YES;
    self.PZL20_BW.hidden = NO;
    self.PZL20_COL.hidden = YES;
    
    self.MedalGold.hidden = YES;
    self.MedalSilver.hidden = NO;
	
	[self puzzleResetImageInteraction:YES];
}

-(IBAction)noteTapped:(UITapGestureRecognizer *)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX03 play];
	
    self.Notepopover.hidden = NO;
	self.Notepopover.userInteractionEnabled = YES;
    
    [self imageAlpha:0.4];
    [self imageUserInteractionEnabled: NO];
	
	[self revealPopoverCloseButton:self.Notepopover.frame];
}

- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender
{

}

- (void) imageAlpha:(float)alpha
{
    self.background.alpha = alpha;
    self.RibbonBase.alpha = alpha;
    self.About.alpha = alpha;
    self.Note.alpha = alpha;
    self.Gramophone.alpha = alpha;
    self.StartReading.alpha = alpha;
    
    // dim the background
    self.DimBackground.hidden = NO;
    self.DimBackground.alpha = 0.45;
}

- (void) imageUserInteractionEnabled:(BOOL)interaction
{
    self.StartReading.userInteractionEnabled = interaction;
    self.About.userInteractionEnabled = interaction;
    self.Note.userInteractionEnabled = interaction;
    self.MiaoHelp_Tapped.userInteractionEnabled = interaction;
    self.MedalSilver.userInteractionEnabled = interaction;
    self.MedalGold.userInteractionEnabled = interaction;
	self.MiaoHelp.userInteractionEnabled = interaction;
}

- (void) loadVisiblePages
{
    // Determine currently visible page
    CGFloat pageWidth = self.scrollView.frame.size.width;
    //NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0f));
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    NSLog(@"Loading page %d",page);
    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        //newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.contentMode = UIViewContentModeScaleToFill;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}


#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.voiceOverPlayer setAudioFile:@"00_ThemeEJJ.mp3"];
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.voiceOverPlayer play];
	
	[self.SFX01 setAudioFile:@"00_medal.mp3"];
	[self.SFX02 setAudioFile:@"00_miao.mp3"];
	[self.SFX03 setAudioFile:@"00_note.mp3"];
	[self.SFX04 setAudioFile:@"00_plane.mp3"];
	[self.SFX05 setAudioFile:@"00_start.mp3"];
	[self.SFX06 setAudioFile:@"00_switch.mp3"];
	
    self.About_BG.hidden = YES;
    self.About_Facebook.hidden = YES;
    self.About_Home.hidden = YES;
    self.About_More.hidden = YES;
    self.About_Rate.hidden = YES;
    
    self.PZL_BG.hidden = YES;
    self.PZL_08BW.hidden = YES;
    self.PZL_08COL.hidden = YES;
    self.PZL_11BW.hidden = YES;
    self.PZL_11COL.hidden = YES;
    self.PZL_14BW.hidden = YES;
    self.PZL_14COL.hidden = YES;
    self.PZL20_BW.hidden = YES;
    self.PZL20_COL.hidden = YES;
    self.PZL_Reset.hidden = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey: @"read aloud player"] isEqualToString:@"YES"]){
        self.Read_ON.hidden = NO;
        self.Read_OFF.hidden = YES;
    } else {
        self.Read_ON.hidden = YES;
        self.Read_OFF.hidden = NO;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey: @"sound effect player"] isEqualToString:@"YES"]) {
        self.SFX_On.hidden = NO;
        self.SFX_Off.hidden = YES;
    } else {
        self.SFX_On.hidden = YES;
        self.SFX_Off.hidden = NO;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle one done"] isEqualToString:@"YES"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two done"] isEqualToString:@"YES"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle three done"] isEqualToString:@"YES"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle ten done"] isEqualToString:@"YES"])
    {
        self.MedalGold.hidden = NO;
        self.MedalSilver.hidden = YES;
    } else {
        self.MedalGold.hidden = YES;
        self.MedalSilver.hidden = NO;
    }
    
    self.scrollView.pagingEnabled = YES;
	self.scrollView.bounces = NO;
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	
	self.trackedViewName = @"Home View Controller";
	
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed: @"00Help_01.jpg"],
                       [UIImage imageNamed: @"00Help_02.jpg"],
                       [UIImage imageNamed: @"00Help_03.jpg"],
                       nil];
    
    NSInteger pageCount = self.pageImages.count;
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    self.pageViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < pageCount; i++) [self.pageViews addObject: [NSNull null]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setRead_OFF:nil];
    [self setAbout_BG:nil];
    [self setAbout_Home:nil];
    [self setAbout_Facebook:nil];
    [self setAbout_Rate:nil];
    [self setAbout_More:nil];
    
    [self setPZL_BG:nil];
    [self setPZL_08BW:nil];
    [self setPZL_08COL:nil];
    [self setPZL_11BW:nil];
    [self setPZL_11COL:nil];
    [self setPZL_14BW:nil];
    [self setPZL_14COL:nil];
    [self setPZL20_BW:nil];
    [self setPZL20_COL:nil];
    [self setPZL_Reset:nil];
    
    [self setHelp_Frame:nil];
    [self setAbout:nil];
    [self setStartReading:nil];
    [self setBackground:nil];
    [self setNotepopover:nil];
    [self setGramophone:nil];
    [self setRibbonBase:nil];
    [self setNote:nil];
    
    self.scrollView = nil;
    self.pageControl = nil;
    self.pageImages = nil;
    self.pageViews = nil;
    
	self.voiceOverPlayer = nil;
	self.SFX01 = nil;
	self.SFX02 = nil;
	self.SFX03 = nil;
	self.SFX04 = nil;
	self.SFX05 = nil;
	self.SFX06 = nil;
	
    [self setDimBackground:nil];
}

- (void)viewDidUnload {
    [self setStartReading:nil];
	[self setAbout:nil];
	[self setAbout:nil];
	[self setNote:nil];
	[self setMiaoHelp:nil];
	[self setPopoverClose:nil];
	[self setWarningReset:nil];
	[self setWarningResetNo:nil];
	[self setWarningResetYes:nil];
	[self setBabyGate:nil];
	[self setThirdCircle:nil];
	[self setOtherCircles:nil];
    [super viewDidUnload];
}
@end
