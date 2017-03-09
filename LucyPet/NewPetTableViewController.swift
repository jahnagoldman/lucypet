//
//  NewPetTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit

class NewPetTableViewController: UITableViewController {

    @IBOutlet weak var petNameField: UITextField!
    
    @IBOutlet weak var microChipField: UITextField!
    
    @IBOutlet weak var dateDetailLabel: UILabel!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    @IBOutlet weak var animalDetailLabel: UILabel!
    var animal:String = "Dog" {
        didSet {
            animalDetailLabel.text = animal
        }
    }
    var pet: Pet?
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDatePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        // only month, day, year and no time shown - ideal for birthday picking
        birthDatePicker.datePickerMode = .date

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 4
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    @IBAction func popoverDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // takes date from date picker and sets the detail label as this date
    // - Attribution: http://stackoverflow.com/questions/40484182/ios-swift-3-uidatepicker
    func datePickerChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            dateDetailLabel.text = "\(day)/\(month)/\(year)"
           
        }
    }
    
    @IBAction func unwindWithSelectedAnimal(segue:UIStoryboardSegue) {
        if let animalPickerTableViewController = segue.source as? AnimalPickerTableViewController, let selectedAnimal = animalPickerTableViewController.selectedAnimal {
            animal = selectedAnimal
            print(animal)
        }
    }
   


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SavePetDetail" {
            var anim: Pet.Animal
            if animal == "Dog" {
                anim = Pet.Animal.dog
            }
            else if animal == "Cat" {
                anim = Pet.Animal.cat
            }
            else {
                anim = Pet.Animal.other
            }
            pet = Pet(name: petNameField.text!, birthday: birthDatePicker.date as NSDate, animal: anim, microChipNumber: microChipField.text!)
            
            
        }
    }
    

}
