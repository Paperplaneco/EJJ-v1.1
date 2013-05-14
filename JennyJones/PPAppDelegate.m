//
//  PPAppDelegate.m
//  JennyJones
//
//  Created by Corey Manders on 11/6/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPAppDelegate.h"
#import "GAI.h"
#import "iRate/iRate.h"

@implementation PPAppDelegate

@synthesize window = _window;

+ (void)initialize
{
    //overriding the default iRate strings
    [iRate sharedInstance].messageTitle = NSLocalizedString(@"Hello again :)", @"iRate message title");
    [iRate sharedInstance].message = NSLocalizedString(@"If you like Extraordinary Jenny Jones, please take the time to rate us.  Jenny will love you for it!", @"iRate message");
    [iRate sharedInstance].cancelButtonLabel = NSLocalizedString(@"No, thanks", @"iRate decline button");
    [iRate sharedInstance].remindButtonLabel = NSLocalizedString(@"Remind me later", @"iRate remind button");
    [iRate sharedInstance].rateButtonLabel = NSLocalizedString(@"Rate us now", @"iRate accept button");
    [iRate sharedInstance].usesUntilPrompt = 5;
    [iRate sharedInstance].previewMode = NO;
    //[iRate sharedInstance].appStoreID = 633392398;
    NSLog(@"iRate initialized");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[NSUserDefaults standardUserDefaults] registerDefaults: [NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"read aloud player", @"YES", @"sound effect player", @"YES", @"play voiceover", nil]];
    
    //[TestFlight takeOff:@"d84ca5370b44a37fdf4a2475364a6f5e_MTgwNjcwMjAxMy0wMS0yOSAwNTowNTozMC44MjU2MzE"];
	
	// Optional: automatically send uncaught exceptions to Google Analytics.
	[GAI sharedInstance].trackUncaughtExceptions = YES;
	// Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
	[GAI sharedInstance].dispatchInterval = 20;
	// Optional: set debug to YES for extra debugging information.
	[GAI sharedInstance].debug = YES;
	// Create tracker instance.
	id<GAITracker>tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39393540-1"];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	[[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
