//
//  UYLNotificationDelegate.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/13/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//



/* Custom Class Description:
 
 This allows for the Local Notifications set in the NotificationViewController to work correctly
 
 */

import Foundation
import UserNotifications

// - Attribution: https://useyourloaf.com/blog/local-notifications-with-ios-10/
class UYLNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")  
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}
