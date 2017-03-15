//
//  SplashScreenViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/12/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//


/* Custom Class Description:
 
 A custom UIViewController that presents a custom splash screen upon launch of the application
 */


import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var splashImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        splashImageView.image = #imageLiteral(resourceName: "LucySplashScreen")
        // splashscreen for delay of 2, then goes to home
        perform(#selector(SplashScreenViewController.showmainmenu), with: nil, afterDelay: 2)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // go to home screen of app
    func showmainmenu(){
        // after delay shows home
        performSegue(withIdentifier: "home", sender: self)
        
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
