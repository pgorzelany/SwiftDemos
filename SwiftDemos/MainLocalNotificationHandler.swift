//
//  MainLocalNotificationHandler.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class MainLocalNotificationHandler {
    
    static let sharedInstance = MainLocalNotificationHandler()
    
    func handleLocalNotification(_ notification: UILocalNotification) {
        AlertUtils.showAlert(title: "Received local notification", body: notification.alertBody)
    }
    
    func handleAction(with identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        if let category = notification.category, let identifier = identifier {
            if category == "like" {
                if identifier == "yes" {
                    AlertUtils.showAlert(title: "NotificationButtonTouched", body: "The yes button was touched")
                } else if identifier == "no" {
                    AlertUtils.showAlert(title: "NotificationButtonTouched", body: "The no button was touched")
                }
            }
        }
        completionHandler()
    }
}
