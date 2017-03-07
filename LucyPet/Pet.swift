//
//  Pet.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import Foundation

class Pet {
    var name: String;
    var birthday: NSDate;
    enum Animal {
        case dog
        case cat
        case other
    }
    var animal: Pet.Animal;
    var microChipNumber: String;
    
    init(name: String, birthday: NSDate, animal: Animal, microChipNumber: String) {
        self.name = name;
        self.birthday = birthday;
        self.animal = animal;
        self.microChipNumber = microChipNumber;
    }
    
    
}
