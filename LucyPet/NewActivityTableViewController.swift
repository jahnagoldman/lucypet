//
//  NewEventTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit


class NewActivityTableViewController: UITableViewController {
    @IBOutlet weak var activityDatePicker: UIDatePicker!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var dateTimeLabel: UILabel!
    var activity: Activity?

    @IBOutlet weak var petDetailLabel: UILabel!
    @IBOutlet weak var activityDetailLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    var activityString: String = "Feeding" {
        didSet {
            activityDetailLabel.text? = activityString
        }
    }
    var pet: Pet?
    var petString: String = "Pet Name" {
        didSet {
            petDetailLabel.text? = petString
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        activityDatePicker.addTarget(self, action: #selector(activityDatePickerChanged(_:)), for :.valueChanged)
//        doneBarButton.isEnabled = false
//        activityDatePicker.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
////        petDetailLabel.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
////        activityDetailLabel.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
//        commentTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activityDatePickerChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minute = components.minute {
            dateTimeLabel.text = "\(month)/\(day)/\(year) \(hour):\(minute)"
        }
    }
    
    func editingChanged(_ textField: UITextField) {
        
    }
    
    @IBAction func unwindWithSelectedActivity(segue:UIStoryboardSegue) {
        if let activityPickerViewController = segue.source as? ActivityPickerTableViewController, let selectedActivity = activityPickerViewController.selectedActivity {
            activityString = selectedActivity
        }
        
    }
    
    @IBAction func unwindWithSelectedPet(segue:UIStoryboardSegue) {
        if let petPickerViewController = segue.source as? PetPickerTableViewController, let selectedPet = petPickerViewController.selectedPet {
            petString = selectedPet
        }
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
        if segue.identifier == "SaveActivityDetail" {
            activity = Activity(petName: petString, dateAndTime: activityDatePicker.date as NSDate, activityType: Activity.ActivityType(rawValue: activityString)!, comments: commentTextField.text!)
            
        }
        
        
        
        
    }
    

}
