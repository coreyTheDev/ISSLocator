//
//  AppDelegate.swift
//  ISSLocator
//
//  Created by Corey Zanotti on 10/17/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//
/*
 *Problem*:
 
 Create an ios application for tracking the International Space Station using the APIs available at http://open-notify.org/.
 
 *Required Features*:
 
 - Detect the user's current location - 1 hour
 - Show the user the next time the ISS will pass over their location - 1 hour
 - Send the user a push notification when the ISS is overhead - 30 min
 
 *Requirements*:
 
 - You should use Swift for the language of choice.
 - I should be able to install and run your application in Xcode by following a readme.
 
 *Optional Features*
 
 - Save multiple favorite locations; display next pass time and send notifications for all saved locations
 - Display the current position of the ISS on a map
 - Display the trajectory of the ISS on a map
 - Unit tests
 
 *Delivery*:
 
 Please commit your code using either git or mercurial and use either bitbucket or github, or a similar service.
 
 If you run into any issues, please contact me directly.
 
 Please deliver the result by 1PM 10/18/2016
 
 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

