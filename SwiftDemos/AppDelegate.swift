//
//  AppDelegate.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var localNotificationHandler = MainLocalNotificationHandler.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.loadAppStructure()
        
        if let localNotification = launchOptions?[UIApplicationLaunchOptionsKey.localNotification] as? UILocalNotification {
            self.localNotificationHandler.handleLocalNotification(localNotification)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        self.localNotificationHandler.handleLocalNotification(notification)
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        self.localNotificationHandler.handleAction(with: identifier, for: notification, completionHandler: completionHandler)
    }
    
    // MARK: Custom Methods
    
    fileprivate func loadAppStructure() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let navController = UINavigationController(rootViewController: TOKViewController.instantiateFromStoryboard())
        window?.rootViewController = navController
    }
}

