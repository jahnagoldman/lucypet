//
//  NotificationViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/13/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//



/* Custom Class Description:
 
 A custom UIViewController that allows for the user to select notification alerts to remind them of pet activities like walks, feedings, etc.
 
 */


import UIKit
import UserNotifications


// - Attribution: https://useyourloaf.com/blog/local-notifications-with-ios-10/
class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet weak var onceButton: UIButton!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var dailyButton: UIButton!
    
    @IBOutlet weak var weeklyButton: UIButton!
    
    @IBOutlet weak var monthlyButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var content: UNMutableNotificationContent?
    var numberNotification: Int?
    
    var trigger: UNNotificationTrigger?
    var activityString: String?
    var activityChosen: Bool?
    
    var dateTime: NSDate?
    let center = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                self.notificationsDisabledAlert()
                
            }

        }
        // add button/picker targets
        datePicker.addTarget(self, action: #selector(activityDatePickerChanged(_:)), for :.valueChanged)
        onceButton.addTarget(self, action: #selector(setOnceReminder), for : .touchUpInside)
        dailyButton.addTarget(self, action: #selector(setDailyReminder), for : .touchUpInside)
        weeklyButton.addTarget(self, action: #selector(setWeeklyReminder), for : .touchUpInside)
        monthlyButton.addTarget(self, action: #selector(setMonthlyReminder), for: .touchUpInside)
        activityChosen = false
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // if notifications were originally disabled when original pop up came up, let user know they need to go change this
    func notificationsDisabledAlert() {
        let alertController = UIAlertController(title: "You have chosen not to allow notifications.", message: "Please go to your settings if you wish to allow them.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // create alert of correct event type
    func createAlert() {
        var identifier: String
        // different identifiers of each type - so can create multiple alerts if different types - if same type, a new one will replace the old one since identifiers are the same
        if activityString == "Feeding" {
            identifier = "FeedingNotification"
        }
        else if activityString == "Walk" {
            identifier = "WalkNotification"
        }
        else if activityString == "Bathroom" {
            identifier = "BathroomNotification"
        }
        else if activityString == "Medication" {
            identifier = "MedicationEvent"
        }
        else {
            identifier = "OtherEvent"
        }
        // create request
        let request = UNNotificationRequest(identifier: identifier, content: content!, trigger: trigger)
        // create content
        content?.sound = UNNotificationSound.default()

        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        // present confirmation that alert has been set
        if let activity = activityString {
            let alertController = UIAlertController(title: "Success.", message: "\(activity) reminder notification is now set.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
       
    }
    
    // set the content based on the specific activity selected
    func setContent() {
        content = UNMutableNotificationContent()
        content?.title = "Reminder"
        content?.sound = UNNotificationSound.default()
        if let activity = activityString {
            content?.body = "This is a \(activity) reminder for your pet."
        }
        
        
    }
    
    // activity must be chosen before setting alert - checks that this has been done
    func checkIfActivityChosen() -> Bool {
        if activityChosen! {
            return true
        }
        else {
            return false
        }
        
    
    }
    
    // alert presented if activity not chosen and user tries to set a notification
    func alertMustChooseActivity() {
        let alertController = UIAlertController(title: "Please choose an activity.", message: "Reminder notifications cannot be set without the activity.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)


    }
    
    // set a notification for 1 time occurrence
    func setOnceReminder()  {
        print("One-Time Reminder button tapped.")

        // check if activity has been chosen, otherwise don't allow for notification to be created
        if (!checkIfActivityChosen()) {
            alertMustChooseActivity()
            return
        }
        if let dateTime = dateTime {
            setContent()
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: dateTime as Date)
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            createAlert()
        }
        
        

    }
    
    // - Attribution: http://stackoverflow.com/questions/40332113/scheduling-weekly-repeatable-local-notification-with-fire-date-from-date-picker
    // set a notification for weekly occurrence - based on set time/date in the UIDatePicker
    func setWeeklyReminder() {
        print("Weekly Reminder button tapped.")
        // check if activity has been chosen, otherwise don't allow for notification to be created
        if (!checkIfActivityChosen()) {
            alertMustChooseActivity()
            return
        }
        if let dateTime = dateTime {
            let alarmTime = dateTime.addingTimeInterval(60 * 60 * 24 * 7 - 300) // One week minus 5 minutes.
            let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: alarmTime as Date)
            trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            createAlert()
        }
        
    }
    // set a notification for daily occurrence - based on set time/date in the UIDatePicker
    func setDailyReminder() {
        print("Daily Reminder button tapped.")

        // check if activity has been chosen, otherwise don't allow for notification to be created
        if (!checkIfActivityChosen()) {
            alertMustChooseActivity()
            return
        }
        if let dateTime = dateTime {
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateTime as Date)
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            createAlert()
            
            
        }
        

        
    }
    
    // set a notification for monthly occurrence - based on set time/date in the UIDatePicker
    func setMonthlyReminder() {
        print("Monthly Reminder button tapped.")

        // check if activity has been chosen, otherwise don't allow for notification to be created
        if (!checkIfActivityChosen()) {
            alertMustChooseActivity()
            return
        }
        if let dateTime = dateTime {
            let alarmTime = dateTime.addingTimeInterval(60 * 60 * 24 * 30 - 300) // 30 days minus 5 minutes.
            let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: alarmTime as Date)
            trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            createAlert()
        }


        
    }
    
    // set dateTime as the date/time set by the user with the UIDatePicker
    func activityDatePickerChanged(_ sender: UIDatePicker) {
        dateTime = sender.date as NSDate?
    }
    
    // sets the activity & label based on what the user has picked in the ActivityPickerTBVC
    @IBAction func unwindWithSelectedActivityNotification(segue:UIStoryboardSegue) {
        if let activityPickerViewController = segue.source as? ActivityPickerTableViewController, let selectedActivity = activityPickerViewController.selectedActivity {
            activityString = selectedActivity
            activityChosen = true
            activityLabel.text = activityString
        }
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
