//
//  ActivityDetailViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/12/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit

class ActivityDetailCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
    
}

/* Custom Class Description:
 
 A custom UITableViewController that presents when the user taps on a pet activity cell in the ActivityTableViewController - presents more detail about the activity (i.e. any comments), as well as option to share the activity (text, add to notes, social media, etc.) using UIActivityViewController
 
 */


class ActivityDetailViewController: UITableViewController {
    
    var activity: Activity?
    var message: String?
    
    @IBOutlet weak var shareButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityDetailCell", for: indexPath) as! ActivityDetailCell
        cell.commentLabel.text = "Comments: " + (activity?.comments)!

        // Configure the cell...

        return cell
    }
    

    // if share button is pressed (top right), bring up options for user to pick from to share the activity 
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("Share Button pressed.")
        let activityViewController = UIActivityViewController(
            activityItems: ["Check out my pet's most recent activity from the LucyPet app!", message ?? "(No activity)"],
            applicationActivities: nil)
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.barButtonItem = (sender as! UIBarButtonItem)
        }
        present(activityViewController, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
