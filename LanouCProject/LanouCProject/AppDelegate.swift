//
//  AppDelegate.swift
//  LanouCProject
//
//  Created by lanou on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        
        var homeViewController = HomeViewController()
        var nav_home = UINavigationController(rootViewController: homeViewController)
        nav_home.tabBarItem = UITabBarItem(title: "主页", image: nil, selectedImage: nil)
        
        //
        var timeViewController = TimeViewController()
        var time_home = UINavigationController(rootViewController: timeViewController)
        time_home.tabBarItem = UITabBarItem(title: "聊天", image: nil, selectedImage: nil)
        
        
        //zhihu
        var zhihu = ZhiHuListViewController()
        var zhihu_home = UINavigationController(rootViewController: zhihu)
        zhihu_home.tabBarItem = UITabBarItem(title: "知乎", image: nil, selectedImage: nil)
        
        //tablebar
        var tabcontroller = UITabBarController()
        tabcontroller.viewControllers = [zhihu_home,time_home,nav_home];
        
        
        self.window?.rootViewController = tabcontroller
        

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

