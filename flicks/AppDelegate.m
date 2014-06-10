//
//  AppDelegate.m
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set up caching - 4mb memory, 20mb of disk
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:20 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIColor *yellow = [UIColor colorWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:yellow];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:yellow, NSForegroundColorAttributeName, nil]];
    [[UINavigationBar appearance] setBarStyle:UIStatusBarStyleLightContent];

    MoviesViewController *moviesViewController = [[MoviesViewController alloc] initWithMode:movieView];
    UINavigationController *moviesNavController = [[UINavigationController alloc] initWithRootViewController:moviesViewController];
    moviesNavController.tabBarItem.title = @"Movies";
    moviesNavController.tabBarItem.image = [UIImage imageNamed:@"MovieIcon"];

    MoviesViewController *dvdViewController = [[MoviesViewController alloc] initWithMode:dvdView];
    UINavigationController *dvdNavController = [[UINavigationController alloc] initWithRootViewController:dvdViewController];
    dvdNavController.tabBarItem.title = @"DVDs";
    dvdNavController.tabBarItem.image = [UIImage imageNamed:@"DVDIcon"];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[moviesNavController, dvdNavController];

    tabBarController.tabBar.tintColor = yellow;
    tabBarController.tabBar.barTintColor = [UIColor blackColor];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor blackColor];
    
    [self.window makeKeyAndVisible];
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
