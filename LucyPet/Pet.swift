//
//  Pet.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//



/* Custom Class Description:
 
 A custom Pet class used to store pet profile data that is entered by the user into a Pet object
 
 */

import Foundation
import UIKit

class Pet: NSObject, NSCoding {
    var name: String
    var birthday: NSDate
    enum Animal: String {
        case Dog
        case Cat
        case Other
    }
    var animal: Pet.Animal
    var microChipNumber: String
    var image: UIImage
    
    init(name: String, birthday: NSDate, animal: Animal, microChipNumber: String, image: UIImage) {
        self.name = name
        self.birthday = birthday
        self.animal = animal
        self.microChipNumber = microChipNumber
        self.image = image
    }
    
    // this function required to be able to decode and retrieve the object from UserDefaults
    // - Attribution: http://stackoverflow.com/questions/38607876/how-to-use-nsuserdefaults-to-store-an-array-of-custom-classes-in-swift
    required init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!
        self.birthday = (aDecoder.decodeObject(forKey: "birthday") as? NSDate)!
        if (aDecoder.decodeObject(forKey: "animal") as? String! == "Dog") {
            self.animal = Pet.Animal.Dog as Pet.Animal
        }
        else if (aDecoder.decodeObject(forKey: "animal") as? String! == "Cat") {
            self.animal = Pet.Animal.Cat as Pet.Animal
        }
        else {
            self.animal = Pet.Animal.Other as Pet.Animal
        }
        self.microChipNumber = (aDecoder.decodeObject(forKey: "microChipNumber") as? String)!
        self.image = (aDecoder.decodeObject(forKey: "image") as? UIImage)!
        
    }
    
    // this function is required to encode the custom object to be stored in UserDefaults
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.birthday, forKey: "birthday")
        // animal is an enum - store as a string - rawvalue
        aCoder.encode(self.animal.rawValue, forKey: "animal")
        aCoder.encode(self.microChipNumber, forKey: "microChipNumber")
        aCoder.encode(self.image, forKey: "image")
        
    }
    
    
}
