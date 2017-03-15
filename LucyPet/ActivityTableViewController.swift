//
//  ActivityTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//


/* Custom Class Description:
 
 A custom TableViewCell for the pet activity cell in the ActivityTableViewController
 
 */

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var activityImageView: UIImageView!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    
    
}

/* Custom Class Description:
 
 A custom TableViewController to display all pet activities added by the user
 
 */

// - Attribution: http://codepany.com/blog/swift-3-expandable-table-view-cells/
class ActivityTableViewController: UITableViewController {
    var activities: [Activity] = [Activity]()
    var filteredData: [Activity]!
    var caption: String?
    var infoButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.data(forKey: "activities"), let myActivityList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Activity] {
            myActivityList.forEach({activities.append($0)})
        }
        // - Attribution: http://stackoverflow.com/questions/34711227/how-to-use-info-button-on-a-uibarbuttonitem
        infoButton = UIButton(type: .infoLight)
        infoButton?.addTarget(self, action: #selector(getInfoAction), for: .touchUpInside)
        // Create a bar button item using the info button as its custom view
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton!)
        // Use it as required
        navigationItem.leftBarButtonItem = infoBarButtonItem
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // if cancel button is clicked in a new view controller to navigate back to this VC without doing anything (e.g. when adding a new activity, but decide to cancel)
    @IBAction func cancelToActivityViewController(segue:UIStoryboardSegue) {
        
    }
    
    // when adding a new activity in the NewActivityTableViewController and the done button is clicked, this method saves the activity to UserDefaults using NSKeyedArchiver - inserts at start of array
    @IBAction func saveActivityDetail(segue:UIStoryboardSegue) {
        if let newActivityViewController = segue.source as? NewActivityTableViewController {
            if let activity = newActivityViewController.activity {
                activities.insert(activity, at: 0)
                activities.sort(by: {$0.dateAndTime.compare($1.dateAndTime as Date) == ComparisonResult.orderedDescending})
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: activities)
                UserDefaults.standard.set(encodedData, forKey: "activities")
                tableView?.reloadData()
            }
        }
    }
    
    
    
    // when the Info button is pressed -- top left of this VC -- perform segue to present the InfoVC
    func getInfoAction() {
        print("Info button pressed.")
        performSegue(withIdentifier: "infoSegue", sender: infoButton)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        let thisActivity = activities[indexPath.row]
        var activityString = ""
        // set image of the cell to the correct activity type image
        if (thisActivity.activityType == .Bathroom) {
            activityString = "went to the bathroom"
            cell.activityImageView.image = #imageLiteral(resourceName: "Toilet Bowl-48")
        }
        else if (thisActivity.activityType == .Feeding) {
            activityString = "was fed"
            cell.activityImageView.image = #imageLiteral(resourceName: "Pizza-48")
        }
        else if (thisActivity.activityType == .Medication) {
            activityString = "took medicine"
            cell.activityImageView.image = #imageLiteral(resourceName: "Pill-48")
        }
        else if (thisActivity.activityType == .Walk) {
            activityString = "went on a walk"
            cell.activityImageView.image = #imageLiteral(resourceName: "Dog Leash-48")
        }
        else {
            activityString = "did an activity"
             cell.activityImageView.image = #imageLiteral(resourceName: "Happy1")
        }
        // set label of the cell to the correct activity sentence with the corresponding pet name, date/time, activity type
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: thisActivity.dateAndTime as Date)
        let components = Calendar.current.dateComponents([.year, .month, .day], from: thisActivity.dateAndTime as Date)
        if let day = components.day, let month = components.month, let year = components.year {
            cell.activityLabel.text = "\(thisActivity.petName) \(activityString) at \(time) on \(month)/\(day)/\(year)."
            caption = cell.activityLabel.text
            
            
        }
        
    

         //Configure the cell...
        

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view. --- able to delete the activities from the table and from UserDefaults by swiping
    // - Attribution: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source -- user defaults
            activities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: activities)
            UserDefaults.standard.set(encodedData, forKey: "activities")
            tableView.reloadData()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        if (segue.identifier == "activityDetailSegue") {
            let secondVC = segue.destination as! ActivityDetailViewController
            let cell = sender as! ActivityTableViewCell
            let path = self.tableView?.indexPath(for: cell)
            // set the activity and message variables of the ActivityDetail VC 
            secondVC.activity = activities[(path?.row)!]
            secondVC.message = cell.activityLabel.text
        }
    }
    

}
