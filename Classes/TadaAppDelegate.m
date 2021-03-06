//
//  TadaAppDelegate.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "TadaAppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"
#import "ConsoleManager.h"
#import "UnitTest.h"
#import "DataForUITest.h"


@implementation TadaAppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;


#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window addSubview:splitViewController.view];
    [self.window makeKeyAndVisible];
	[UnitTest setup];
	[UnitTest run_all_tests];
	[UnitTest report];
	
//	[DataForUITest test_data_for_ui];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}
-(void)configureView{
	[rootViewController configureView];
	[detailViewController configureView];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

