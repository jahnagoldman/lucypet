//
//  Activity.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/10/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import Foundation
import UIKit

class Activity: NSObject, NSCoding {
    var petName: String
    var dateAndTime: NSDate
        enum ActivityType: String {
        case Bathroom
        case Medication
        case Feeding
        case Walk
        case Other
    }
    var activityType: Activity.ActivityType
    var comments: String
    
    init(petName: String, dateAndTime: NSDate, activityType: Activity.ActivityType, comments: String) {
        self.petName = petName
        self.dateAndTime = dateAndTime
        self.activityType = activityType
        self.comments = comments
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dateAndTime = (aDecoder.decodeObject(forKey: "dateAndTime") as? NSDate)!
        self.comments = (aDecoder.decodeObject(forKey: "comments") as? String)!
        self.activityType = Activity.ActivityType(rawValue: (aDecoder.decodeObject(forKey: "activityType") as? String)!)!
        self.petName = (aDecoder.decodeObject(forKey: "petName") as? String)!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dateAndTime, forKey: "dateAndTime")
        aCoder.encode(self.comments, forKey: "comments")
        aCoder.encode(self.activityType.rawValue, forKey: "activityType")
        aCoder.encode(self.petName, forKey: "petName")
        
    }

    
    
}
