//
//  YourPetsCollectionViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//


/* Custom Class Description:
 
 A custom CollectionViewController to display all pet profiles added by the user
 
 */

import UIKit

private let reuseIdentifier = "petCell"

class YourPetsCollectionViewController: UICollectionViewController {
    
    var pets: [Pet] = [Pet]()
    // button to add a new pet, in nav bar
    @IBOutlet weak var newPetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load view with storerd pets in UserDefaults
        if let data = UserDefaults.standard.data(forKey:"pets"), let myPetList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Pet] {
            myPetList.forEach({pets.append($0)})
       }
        collectionView?.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "detailSegue") {
            let secondVC = segue.destination as! PetDetailViewController
            let cell = sender as! YourPetViewCell
            let path = self.collectionView?.indexPath(for: cell)
            // pass pet data to pet detail VC
            secondVC.pet = pets[(path?.row)!]
            secondVC.index = path?.row
            
            
        }
    }
    

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
       
        // Configure the cell - set pet name and image
        cell.nameLabel.text = thisPet.name
        cell.petImageView.image = thisPet.image
        return cell
    }
    
    // if cancel button is clicked in a new view controller to navigate back to this VC without doing anything (e.g. when adding a new pet, but decide to cancel)
    @IBAction func cancelToPetsViewController(segue:UIStoryboardSegue) {
        
    }
    
    // when adding a new pet in the NewPetTableViewController and the done button is clicked, this method saves the pet to UserDefaults using NSKeyedArchiver - inserts at start of array
    @IBAction func savePetDetail(segue:UIStoryboardSegue) {
        if let newPetViewController = segue.source as? NewPetTableViewController {
            if let pet = newPetViewController.pet {
                pets.insert(pet, at: 0)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: pets)
                UserDefaults.standard.set(encodedData, forKey: "pets")
                collectionView?.reloadData()
            }
        }
    }
    
    // to delete the pet profile
    func didDismiss(withData: Int) {
        pets.remove(at: withData)
        print(withData)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: pets)
        UserDefaults.standard.set(encodedData, forKey: "pets")
        collectionView?.reloadData()
    }
    
    // to delete the pet profile and go back to list of pets from the detail page
    @IBAction func unwindToPetList(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! PetDetailViewController
        pets.remove(at: sourceVC.index!)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: pets)
        UserDefaults.standard.set(encodedData, forKey: "pets")
        collectionView?.reloadData()
        
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
