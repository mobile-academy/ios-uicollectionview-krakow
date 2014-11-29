//
//  AppDelegate.m
//  DynamicsExample
//
//  Created by Robert Wijas on 26/07/14.
//  Copyright (c) 2014 Robert Wijas. All rights reserved.
//

#import "AppDelegate.h"
#import "FBTweakViewController.h"
#import "FBTweakStore.h"
#import "DynamicsExampleViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    
    FBTweakViewController *tweakViewController = [[FBTweakViewController alloc] initWithStore:[FBTweakStore sharedInstance]];
    tweakViewController.navigationItem.rightBarButtonItem = nil;
    
    splitViewController.viewControllers = @[tweakViewController, [[DynamicsExampleViewController alloc] init]];
    
    self.window.rootViewController = splitViewController;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
