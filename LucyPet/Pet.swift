//
//  Pet.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import Foundation
import UIKit

class Pet: NSObject, NSCoding {
    var name: String
    var birthday: NSDate
    enum Animal: String {
        case dog
        case cat
        case other
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
    
    // - Attribution: http://stackoverflow.com/questions/38607876/how-to-use-nsuserdefaults-to-store-an-array-of-custom-classes-in-swift
    required init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!
        self.birthday = (aDecoder.decodeObject(forKey: "birthday") as? NSDate)!
        if (aDecoder.decodeObject(forKey: "animal") as? String! == "Dog") {
            self.animal = Pet.Animal.dog as Pet.Animal
        }
        else if (aDecoder.decodeObject(forKey: "animal") as? String! == "Cat") {
            self.animal = Pet.Animal.cat as Pet.Animal
        }
        else {
            self.animal = Pet.Animal.other as Pet.Animal
        }
        self.microChipNumber = (aDecoder.decodeObject(forKey: "microChipNumber") as? String)!
        self.image = (aDecoder.decodeObject(forKey: "image") as? UIImage)!
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.birthday, forKey: "birthday")
        aCoder.encode(self.animal.rawValue, forKey: "animal")
        aCoder.encode(self.microChipNumber, forKey: "microChipNumber")
        aCoder.encode(self.image, forKey: "image")
        
    }
    
    
}
