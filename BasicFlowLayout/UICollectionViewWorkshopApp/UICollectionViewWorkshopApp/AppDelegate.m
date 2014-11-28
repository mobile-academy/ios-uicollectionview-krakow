//
//  Created by Maciej Oczko.
//  Copyright (c) 2014 Mobile Workshops. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "CollectionViewDataSource.h"
#import "CollectionViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    CollectionViewDataSource *dataSource = [CollectionViewDataSource new];
    CollectionViewController *collectionViewController = [[CollectionViewController alloc] initWithDataSource:dataSource];
    RootViewController *rootViewController = [[RootViewController alloc] initWithContentViewController:collectionViewController];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
