//
//  NewEventTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//


/* Custom Class Description:
 
 A custom TableViewController with a static table for the user to add a new pet activity that has occurred; acts as a form to submit the activity
 
 */

import UIKit



class NewActivityTableViewController: UITableViewController {
    @IBOutlet weak var activityDatePicker: UIDatePicker!

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var dateTimeLabel: UILabel!
    var activity: Activity?

    @IBOutlet weak var petDetailLabel: UILabel!
    @IBOutlet weak var activityDetailLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    // var when selecting type of activity
    var activityString: String = "Feeding" {
        didSet {
            activityDetailLabel.text? = activityString
        }
    }
    var pet: Pet?
    // var when selecting which pet profile
    var petString: String = "Pet Name" {
        didSet {
            petDetailLabel.text? = petString
        }
    }
    // keeps track if the fields have been selected or not
    var petChosen: Bool?
    var activityChosen: Bool?
    var dateChosen: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petChosen = false
        activityChosen = false
        dateChosen = false
        // disable the button until the fields are completed
        doneBarButton.isEnabled = false
         activityDatePicker.addTarget(self, action: #selector(activityDatePickerChanged(_:)), for :.valueChanged)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

    }
    
    // checks if the form is complete to see if the donebarButton should be enabled again - starts out disabled until required fields - petname, activitytype, and date - are completed so that blank events don't get created
    func checkFormComplete() {
        if (petChosen! && activityChosen! && dateChosen!) {
            doneBarButton.isEnabled = true
        }
        else {
            doneBarButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // changes detail label when the user changes datepicker to a selected date/time and formats the date
    func activityDatePickerChanged(_ sender: UIDatePicker) {
        print("DatePicker changed.")
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            dateTimeLabel.text = "\(month)/\(day)/\(year) " + time
        }
        // now date is chosen, and should check if the form is complete and if donebutton should be enabled
        dateChosen = true
        checkFormComplete()
    }
    
    
    
    func editingChanged(_ textField: UITextField) {
        
    }
    
    // from activitypicker view, passes the selected activity back to this VC so we have the activity type info from the detail view into this form
    @IBAction func unwindWithSelectedActivity(segue:UIStoryboardSegue) {
        if let activityPickerViewController = segue.source as? ActivityPickerTableViewController, let selectedActivity = activityPickerViewController.selectedActivity {
            activityString = selectedActivity
            activityChosen = true
        }
        // check if donebutton can be enabled
        checkFormComplete()
        
    }
    
    // from the pet picker, passes the selected pet back to this VC so we have the pet info from the detail view into this form
    @IBAction func unwindWithSelectedPet(segue:UIStoryboardSegue) {
        if let petPickerViewController = segue.source as? PetPickerTableViewController, let selectedPet = petPickerViewController.selectedPet {
            petString = selectedPet
            petChosen = true
        }
        // check if donebutton can be enabled
        checkFormComplete()
        
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
            // pass the activity info to the main VC so it can be saved
            activity = Activity(petName: petString, dateAndTime: activityDatePicker.date as NSDate, activityType: Activity.ActivityType(rawValue: activityString)!, comments: commentTextField.text!)
            print("Done button pressed - activity saved.")
            
        }
        
        
        
        
    }
    

}
