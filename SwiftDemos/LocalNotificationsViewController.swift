//
//  LocalNotificationsViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class LocalNotificationsViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "LocalNotifications"
    
    // MARK: Outlets
    @IBOutlet weak var notificationBadgeNumberTextField: UITextField!
    @IBOutlet weak var notificationTitleTextField: UITextField!
    @IBOutlet weak var timerPickerView: UIPickerView!
    @IBOutlet weak var scheduleButton: UIButton!
    
    // MARK: Properties
    
    let timePickerOption: [TimeInterval] = [5, 10, 20, 30, 40, 50, 60]
    
    /** The time ins seconds when the notification will fire */
    lazy var notificationTime: TimeInterval = {
        return self.timePickerOption[0]
    }()
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Local Notifications Demo"
        timerPickerView.selectRow(0, inComponent: 0, animated: false)
        
        self.registerForLocalNotifications()
        
    }
    
    // MARK: Actions
    
    @IBAction func scheduleButtonTouched(_ sender: UIButton) {
        
        
        let notification = UILocalNotification()
        notification.fireDate = Date().addingTimeInterval(self.notificationTime)
        notification.alertBody = self.notificationTitleTextField.text
        notification.alertTitle = "This is the alert title"
        notification.category = "like" // Must be the same as the registered category
        if let badgeText = notificationBadgeNumberTextField.text,  let badgeNumber = Int(badgeText) {
            notification.applicationIconBadgeNumber = badgeNumber
        }
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    
    // MARK: Support
    
    fileprivate func registerForLocalNotifications() {
        
        let action1 = UIMutableUserNotificationAction()
        action1.identifier = "yes"
        action1.title = "yes"
        action1.isAuthenticationRequired = false
        action1.activationMode = .foreground
        action1.isDestructive = false
        
        let action2 = UIMutableUserNotificationAction()
        action2.identifier = "no"
        action2.title = "no"
        action2.isAuthenticationRequired = false
        action2.activationMode = .foreground
        action2.isDestructive = true
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "like"
        category.setActions([action1, action2], for: UIUserNotificationActionContext.default)
        
        var categories = Set<UIMutableUserNotificationCategory>()
        categories.insert(category)
        
        let notificationsSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: categories)
        
        UIApplication.shared.registerUserNotificationSettings(notificationsSettings)
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension LocalNotificationsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.timePickerOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "in \(Int(self.timePickerOption[row])) seconds"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.notificationTime = self.timePickerOption[row]
    }
    
}
