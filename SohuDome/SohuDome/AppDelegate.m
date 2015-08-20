//
//  AppDelegate.m
//  SohuDome
//
//  Created by lanou3g on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LibrayViewController.h"
#import "DownLoadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //给homeNav添加文字和图片
    HomePageViewController *homePage = [HomePageViewController new];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homePage];
    UITabBarItem *homeItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"1.png"] tag:1];
    homePage.tabBarItem=homeItem;
   
    
    
    //给libraryNav添加文字和图片
    LibrayViewController *library = [LibrayViewController new];
    UITabBarItem *libraryItem=[[UITabBarItem alloc]initWithTitle:@"片库" image:[UIImage imageNamed:@"2.png"] tag:1];
    library.tabBarItem=libraryItem;
    UINavigationController *libraryNav = [[UINavigationController alloc]initWithRootViewController:library];
    
    
    DownLoadViewController *downLoadVC = [DownLoadViewController new];
    UITabBarItem *downLoadItem=[[UITabBarItem alloc]initWithTitle:@"下载" image:[UIImage imageNamed:@"3.png"] tag:1];
    downLoadVC.tabBarItem=downLoadItem;

    UINavigationController *downloadNav = [[UINavigationController alloc]initWithRootViewController:downLoadVC];
    
    
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = @[homeNav,libraryNav,downloadNav];
    
    
    self.window.rootViewController = tabBar;
    [homePage release];
    [homeNav release];
    [library release];
    [libraryNav release];
    [downLoadVC release];
    [downloadNav release];
    [tabBar release];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
