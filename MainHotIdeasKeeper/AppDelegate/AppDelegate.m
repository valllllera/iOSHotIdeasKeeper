//
//  AppDelegate.m
//  HotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 16.04.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuScreenViewController.h"
#import "MainScreenViewController.h"
#import "NotesScreenViewController.h"
#import "NVSlideMenuController.h"
#import "ViewNotesViewController.h"
#import "AboutScreenViewController.h"
#import "AddPlaceOnMapViewController.h"
#import "CameraScreenViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    MainScreenViewController *mainScreenViewController = [[MainScreenViewController alloc]init];
    MenuScreenViewController *menuScreenViewController = [[MenuScreenViewController alloc]init];
    NotesScreenViewController *notesScreenViewController = [[NotesScreenViewController alloc]init];
    ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
    AboutScreenViewController *aboutScreenViewController = [[AboutScreenViewController alloc]init];
    AddPlaceOnMapViewController *addPlaceONMapViewController = [[AddPlaceOnMapViewController alloc]init];
    CameraScreenViewController *cameraScreenViewController = [[CameraScreenViewController alloc]init];
    
    
    UINavigationController *mainNavigationController = [[UINavigationController alloc]initWithRootViewController:mainScreenViewController];
    self.window.rootViewController = mainNavigationController;
    
    UINavigationController *notesScreenNavigationController = [[UINavigationController alloc]initWithRootViewController:notesScreenViewController];
    self.window.rootViewController = notesScreenNavigationController;
    
    UINavigationController *viewNotesNavigationController = [[UINavigationController alloc]initWithRootViewController:viewNotesViewController];
    self.window.rootViewController = viewNotesNavigationController;
    
    UINavigationController *aboutScreenNavigationController = [[UINavigationController alloc]initWithRootViewController:aboutScreenViewController];
    self.window.rootViewController = aboutScreenNavigationController;
    
    UINavigationController *addPlaceOnMapNavigationController = [[UINavigationController alloc]initWithRootViewController:addPlaceONMapViewController];
    self.window.rootViewController = addPlaceOnMapNavigationController;
    
    UINavigationController *cameraScreenNavigationController = [[UINavigationController alloc]initWithRootViewController:cameraScreenViewController];
    self.window.rootViewController = cameraScreenNavigationController;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    NVSlideMenuController *slideMenuViewController = [[NVSlideMenuController alloc] initWithMenuViewController:menuScreenViewController andContentViewController:mainNavigationController];
    self.window.rootViewController = slideMenuViewController;

    
    
    self.window.backgroundColor = [UIColor whiteColor];
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
