//
//  PPRootView.m
//  JennyJones
//
//  Created by Corey Manders on 31/7/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPRootView.h"
#import <QuartzCore/QuartzCore.h>
#import "NavViewController.h"

@interface PPRootView ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (assign) BOOL isTextController;
@property (strong) UIImageView * pageCurl;
@property (strong) UIPageViewController * pageViewController;
@property (strong) NSUserDefaults * defaults;
@property (strong, nonatomic) NavViewController *nav;

-(void) flipToPage:(int) pageNumber;

@end

@implementation PPRootView

@synthesize pageViewController = _pageViewController;
@synthesize viewControllers = _viewControllers;
@synthesize pageCurl = _pageCurl;
@synthesize defaults = _defaults;
@synthesize navTassle = _navTassle;
@synthesize nav = _nav;

- (void) pageMove: (NSNotification *) pNotification
{
    NSString *message = (NSString *) [pNotification object];
    
    if ([message isEqualToString:@"forward"])
		[self flipToPage:[[self.defaults objectForKey:@"current page"] intValue] + 1];
    else if ([message isEqualToString:@"back"])
		[self flipToPage:[[self.defaults objectForKey:@"current page"] intValue] - 1];
    else if ([message isEqualToString:@"user selected page"])
		[self flipToPage:[self.defaults integerForKey:@"user selected page"]];
	
    else {
        if ([[self.defaults objectForKey:@"current page"] intValue] == 0)
            [self flipToPage:1];
        else
            [self flipToPage: [[self.defaults objectForKey:@"current page"] intValue]];
    }
}

-(void) flipToPage:(int) pageNumber
{
    // make sure we are in a good range
    if (pageNumber  < 0 || pageNumber >= self.viewControllers.count) return;
    
    NSString * controllerName = [self.viewControllers objectAtIndex:pageNumber];
    
    [self.defaults setObject:[NSNumber numberWithInt:pageNumber] forKey:@"current page"];
    [self.defaults synchronize];
    
    UIViewController * vc = [self getViewControllerWithName:controllerName];
    
    NSArray *viewControllers = nil;
    viewControllers = @[vc];
	NSLog(@"Page numbe is %d",pageNumber);
	if (pageNumber == 0 ) self.navTassle.hidden= YES;
	else self.navTassle.hidden= NO;
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"did finish animating");
    UIViewController * currentController = [self.pageViewController.viewControllers objectAtIndex:0];
    for (int i=0; i< self.viewControllers.count;i++){
        if ([currentController.title isEqualToString:[self.viewControllers objectAtIndex:i]] && i != 0){
            [self.defaults setObject:[NSNumber numberWithInt:i] forKey:@"current page"];
            [self.defaults synchronize];
        }
    }
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;

}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    self.pageCurl.hidden = YES;
    UIViewController * vc;
    
    NSString * firstViewControllerTitle = [self.viewControllers objectAtIndex:0];
    if ([viewController.title isEqualToString:firstViewControllerTitle]) return nil;
    else {
        for (int i = 1;i<self.viewControllers.count;i++)
            if([[self.viewControllers objectAtIndex:i] isEqualToString:viewController.title] ){
                NSString * vcName = [self.viewControllers objectAtIndex:i-1];
                vc = [self getViewControllerWithName:vcName];
            }
    }
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    self.pageCurl.hidden = YES;
    UIViewController * vc;
    
    NSString * lastViewControllerTitle = [self.viewControllers lastObject];
    if ([viewController.title isEqualToString:lastViewControllerTitle]) return nil;
    else {
        for (int i = 0;i<self.viewControllers.count-1;i++)
            if([[self.viewControllers objectAtIndex:i] isEqualToString:viewController.title] ){
                NSString * vcName = [self.viewControllers objectAtIndex:i+1];
                vc = [self getViewControllerWithName:vcName];
            }
    }
    return vc;    
}

-(UIViewController *) getViewControllerWithName:(NSString * )name
{
    UIViewController *vc;
    NSLog(@"getting controller with name %@",name);
    vc = [self.storyboard instantiateViewControllerWithIdentifier:name];
    return vc;
}

-(void)viewWillAppear:(BOOL)animated{
//    self.pageCurl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PageCurl.png"]];
//    
//    CGSize curlSize = self.view.bounds.size;
//    curlSize.width = curlSize.width/10.0;
//    curlSize.height = curlSize.height/10.0;
//    CGPoint curlTopLeft = CGPointMake(self.view.bounds.size.width-curlSize.width,
//                                      self.view.bounds.size.height-curlSize.height);
//    
//    self.pageCurl.frame = CGRectMake(curlTopLeft.x,curlTopLeft.y, curlSize.width, curlSize.height);
//    
//    
//    self.pageCurl.layer.anchorPoint = CGPointMake(1.0f, 1.0f);
//    
//    CGAffineTransform trans = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 0.75);
//    
//    self.pageCurl.center = CGPointMake(self.pageCurl.center.x+self.pageCurl.frame.size.width/2, self.pageCurl.center.y+self.pageCurl.frame.size.height/2);
//    [self.view addSubview:self.pageCurl];
//    self.pageCurl.transform = trans;
//    [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionRepeat| UIViewAnimationOptionAutoreverse  animations:^{
//        self.pageCurl.transform =CGAffineTransformIdentity;
//    }completion:nil];
	
	[super viewWillAppear:animated];
	
	self.nav = [self.storyboard instantiateViewControllerWithIdentifier:@"nav"];
	
	self.navTassle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav_tassel.png"]];
	self.navTassle.center = CGPointMake(30, 50);
	self.navTassle.userInteractionEnabled = YES;
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tasslePanned:)];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tasselTapped:)];
	
	[self.navTassle addGestureRecognizer:pan];
	[self.navTassle addGestureRecognizer:tap];
	self.navTassle.hidden = YES;
	[self.view addSubview:self.navTassle];
	
	
	[self.defaults setObject:@"NO" forKey:@"nav showing"];
	[self.defaults synchronize];
}

- (void) showNavWithViewController:(UIView *) view
{	
	[self.view addSubview:view];
	view.center = CGPointMake(512, -384);
	self.navTassle.userInteractionEnabled = NO;

	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		view.center = CGPointMake(512, 384);
	} completion:^(BOOL finished) {
		self.navTassle.userInteractionEnabled = YES;
	}];
}

- (void) hideNavWithViewController:(UIView *) view
{
	self.navTassle.userInteractionEnabled = NO;
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		view.center = CGPointMake(512, -384);
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
		self.navTassle.userInteractionEnabled = YES;
	}];
}

- (void) tasselTapped: (UITapGestureRecognizer *) recognizer
{
	[self tasselTappedOrPanned];
}

- (void) tasslePanned:(UIPanGestureRecognizer *) recognizer
{
	if (([recognizer state] == UIGestureRecognizerStateEnded) && ([recognizer translationInView:self.view].y > 0))
		[self tasselTappedOrPanned];
}

- (void) tasselTappedOrPanned
{	
	if ([[self.defaults objectForKey:@"nav showing"] isEqualToString:@"YES"])
	{
		[self.defaults setObject:@"NO" forKey:@"nav showing"];
		[self.defaults synchronize];
		
		[self hideNavWithViewController:self.nav.view];
		[self.view bringSubviewToFront:self.navTassle];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NavShow" object:@"NO"];
	}
	else if ([[self.defaults objectForKey:@"nav showing"] isEqualToString:@"NO"])
	{
		[self.SFX01 setAudioFile:@"STB_sfx.mp3"];
		if ([[self.defaults objectForKey:@"sound effect player"] isEqualToString:@"YES"]) [self.SFX01 play];
		
		[self.defaults setObject:@"YES" forKey:@"nav showing"];
		[self.defaults synchronize];
		
		[self showNavWithViewController:self.nav.view];
		[self.view bringSubviewToFront:self.navTassle];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NavShow" object:@"YES"];
	}
	
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.navTassle.center = CGPointMake(30, 85);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.15 animations:^{
			self.navTassle.center = CGPointMake(30, 50);
		}];
	}];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![self.defaults objectForKey:@"current page"]){
        [self.defaults setObject:[NSNumber numberWithInt:1] forKey:@"current page"];
        [self.defaults synchronize];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // put in the view controller identifiers
    self.navigationController.toolbarHidden= YES;
    self.navigationController.navigationBarHidden = YES;
    self.defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * pageViewOptions = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin], UIPageViewControllerOptionSpineLocationKey, nil];
    
    
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:pageViewOptions];
    self.pageViewController.view.backgroundColor = [UIColor redColor];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
	
   
    NSLog(@"About to instantiate with Controller named %@",[self.viewControllers objectAtIndex:0]);
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:[self.viewControllers objectAtIndex:0]];
    
    NSArray *pageViewControllers = [NSArray arrayWithObject:vc];
    [self.pageViewController setViewControllers:pageViewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    NSLog(@"Views : %@", self.viewControllers);
    [self addChildViewController:self.pageViewController];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    [[self view] addSubview:[self.pageViewController view]];
    [self.pageViewController didMoveToParentViewController:self];
    
    for (UIGestureRecognizer* gest in self.view.gestureRecognizers)
    {
        if ([gest isKindOfClass:[UIPanGestureRecognizer class]]) [gest setEnabled:NO];
        if ([gest isKindOfClass:[UITapGestureRecognizer class]]) [gest setEnabled:NO];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageMove:) name:@"Page" object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) return YES;
    return NO;
}

@end
