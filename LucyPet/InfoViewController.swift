//
//  InfoViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/13/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//



/* Custom Class Description:
 
 A custom UIViewController that presents information about the Lucy Pet app when the info button is clicked on the Recent Activity tab 
 */

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.addTarget(self, action: #selector(okClicked), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // dismiss the VC when ok is clicked - go back to home page
    func okClicked() {
        print("Ok button tapped.")
        self.dismiss(animated: true, completion: nil)
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
