//
//  ActivityTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var activityImageView: UIImageView!
    
    
    
}

class ActivityTableViewController: UITableViewController {
    
    var activities: [Activity] = [Activity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.data(forKey: "activities"), let myActivityList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Activity] {
            myActivityList.forEach({activities.append($0)})
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelToActivityViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveActivityDetail(segue:UIStoryboardSegue) {
        if let newActivityViewController = segue.source as? NewActivityTableViewController {
            if let activity = newActivityViewController.activity {
                activities.append(activity)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: activities)
                UserDefaults.standard.set(encodedData, forKey: "activities")
                tableView?.reloadData()
            }
        }
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
        cell.petNameLabel.text = thisActivity.petName
        cell.activityLabel.text = thisActivity.activityType.rawValue
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: thisActivity.dateAndTime as Date)
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minute = components.minute {
            cell.dateLabel.text = "\(day)/\(month)/\(year) \(hour):\(minute)"
            if (thisActivity.activityType == .Bathroom) {
                cell.activityImageView.image = #imageLiteral(resourceName: "Toilet Bowl Filled-50")
            }
            else if (thisActivity.activityType == .Feeding) {
                cell.activityImageView.image = #imageLiteral(resourceName: "Restaurant-50")
            }
            else if (thisActivity.activityType == .Medication) {
                cell.activityImageView.image = #imageLiteral(resourceName: "Pill-50")
            }
            else if (thisActivity.activityType == .Walk) {
                cell.activityImageView.image = #imageLiteral(resourceName: "Dog Leash-50")
            }
            else {
                cell.activityImageView.image = #imageLiteral(resourceName: "Happy-50")
            }
        }
        
        cell.commentLabel.text = thisActivity.comments

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

    
    // Override to support editing the table view.
    // - Attribution: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
