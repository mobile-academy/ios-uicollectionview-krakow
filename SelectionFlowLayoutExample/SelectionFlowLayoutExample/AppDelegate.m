//
//  AppDelegate.m
//  SelectionFlowLayoutExample
//
//  Created by Robert Wijas on 26/07/14.
//  Copyright (c) 2014 Robert Wijas. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectionFlowLayoutExampleViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[SelectionFlowLayoutExampleViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
