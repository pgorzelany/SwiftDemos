//
//  MainLocalNotificationHandler.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class MainLocalNotificationHandler: LocalNotificationHandler {
    
    static let sharedInstance = MainLocalNotificationHandler()
    
    func handleLocalNotification(_ notification: UILocalNotification) -> Bool {
        
        AlertUtils.showAlert(title: "Received local notification", body: notification.alertBody)
        
        return false
    }
    
}
