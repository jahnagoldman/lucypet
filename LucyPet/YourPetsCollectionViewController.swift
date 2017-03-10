//
//  YourPetsCollectionViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "petCell"

class YourPetsCollectionViewController: UICollectionViewController {
    
    var pets: [Pet] = [Pet]()

    // button to add a new pet, in nav bar
    @IBOutlet weak var newPetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pets.removeAll()
        if let data = UserDefaults.standard.data(forKey:"pets"), let myPetList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Pet] {
            myPetList.forEach({pets.append($0)})
       }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! YourPetViewCell
        let thisPet = pets[indexPath.row]
        var thisAnimal: String
        if (thisPet.animal == .dog) {
            thisAnimal = "Dog"
        }
        else if (thisPet.animal == .cat) {
            thisAnimal = "Cat"
        }
        else {
            thisAnimal = "Other"
        }
        let mytext = "Pet Name: " + thisPet.name + " Animal Type: " + thisAnimal + " Birthday: " + String(describing: thisPet.birthday) + " Microchip #: " + thisPet.microChipNumber
        // Configure the cell
        cell.petText.text = mytext
        cell.petImageView.image = pets[indexPath.row].image
    
        return cell
    }
    
    @IBAction func cancelToPetsViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func savePetDetail(segue:UIStoryboardSegue) {
        if let newPetViewController = segue.source as? NewPetTableViewController {
            if let pet = newPetViewController.pet {
                pets.append(pet)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: pets)
                UserDefaults.standard.set(encodedData, forKey: "pets")
                collectionView?.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
