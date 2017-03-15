//
//  AnimalPickerTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/9/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

/* Custom Class Description:
 
 A custom TableViewController for the user to pick the animal type when adding a new pet - segue from NewPetTableViewController leads to this page when the animal type cell is tapped
 
 */
import UIKit

// To pick animal type for the Add a New Pet View Controller
// - Attribution: https://www.raywenderlich.com/113394/storyboards-tutorial-in-ios-9-part-2
class AnimalPickerTableViewController: UITableViewController {
    var animals:[String] = [ "Dog", "Cat", "Other"]
    var selectedAnimal:String? {
        didSet {
            if let animal = selectedAnimal {
                selectedAnimalIndex = animals.index(of: animal)
            }
        }
    }
    var selectedAnimalIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = animals[indexPath.row]
        // selected animal has a checkmark, otherwise does not
        if indexPath.row == selectedAnimalIndex {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // other row is selected, need to deselect - undo checkmark
        if let index = selectedAnimalIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        selectedAnimal = animals[indexPath.row]
        // update checkmark for current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }

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
        if segue.identifier == "SaveSelectedAnimal" {
            // pass data for picked animal type
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedAnimal = animals[index]
                }
            }
        }
    }
    

}
