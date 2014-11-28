//
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//

#import "AppDelegate.h"
#import "StackViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[StackViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end