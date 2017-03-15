//
//  PetDetailViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/11/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//


/* Custom Class Description:
 
 A custom UIViewController that presents when the user taps on a pet profile in the YourPetsCollectionViewController - presents more detail about the pet, as well as option to delete the pet
 
 */

import UIKit

class PetDetailViewController: UIViewController {
    @IBOutlet weak var petDescription: UITextView!

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var petImageView: UIImageView!
    var pet: Pet?
    var index: Int?
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let components = Calendar.current.dateComponents([.year, .month, .day], from: pet?.birthday as! Date)
        var date: String = ""
        if let day = components.day, let month = components.month, let year = components.year {
            date = "\(day)/\(month)/\(year)"
        }
        if let pet = pet {
            petDescription.text = "Name: " + pet.name + "\nAnimal: " + pet.animal.rawValue + "\nBirthday: " + date + "\nMicrochip #: " + pet.microChipNumber
            petImageView.image = pet.image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // if the delete button (trash can) is pressed, bring up alert controller to confirm the choice
    // if user clicks OK, then unwind back to petlist and delete pet
    @IBAction func deletePressed(_ sender: Any) {
        print("Delete button tapped.")
        let alertController = UIAlertController(title: "Delete This Pet?", message: "Choose an option.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
            print("You have chosen not to delete the pet.");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            print("You have pressed Yes to delete the pet.")
            self.performSegue(withIdentifier: "unwindToPetList", sender: self)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
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
