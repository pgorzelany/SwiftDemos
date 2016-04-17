//
//  LocalNotificationHandler.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

protocol LocalNotificationHandler {
    
    func handleLocalNotification(notification: UILocalNotification) -> Bool
    
}
