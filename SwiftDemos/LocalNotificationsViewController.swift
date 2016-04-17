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
    
    let timePickerOption: [NSTimeInterval] = [5, 10, 20, 30, 40, 50, 60]
    
    /** The time ins seconds when the notification will fire */
    lazy var notificationTime: NSTimeInterval = {
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
    
    @IBAction func scheduleButtonTouched(sender: UIButton) {
        
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate().dateByAddingTimeInterval(self.notificationTime)
        notification.alertBody = self.notificationTitleTextField.text
        notification.alertTitle = "This is the alert title"
        notification.alertAction = "Action!"
        if let badgeText = notificationBadgeNumberTextField.text,  badgeNumber = Int(badgeText) {
            notification.applicationIconBadgeNumber = badgeNumber
        }
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    // MARK: Support
    
    private func registerForLocalNotifications() {
        
        
        // TODO: Check what are categories
        let notificationsSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationsSettings)
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension LocalNotificationsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.timePickerOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "in \(Int(self.timePickerOption[row])) seconds"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.notificationTime = self.timePickerOption[row]
    }
    
}
