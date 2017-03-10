//
//  NewPetTableViewController.swift
//  LucyPet
//
//  Created by Jahna Arielle Goldman on 3/7/17.
//  Copyright © 2017 Jahna Goldman. All rights reserved.
//

import UIKit

class NewPetTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    var image: UIImage = #imageLiteral(resourceName: "Dog Footprint-26")
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var petImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDatePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        // only month, day, year and no time shown - ideal for birthday picking
        birthDatePicker.datePickerMode = .date
        petImageView.image = image

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
            pet = Pet(name: petNameField.text!, birthday: birthDatePicker.date as NSDate, animal: anim, microChipNumber: microChipField.text!, image: self.image)
            
            
        }
    }
    
    @IBAction func pickPhoto(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Would you like to select an image from your Camera Roll or take a new photo with your camera?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let cameraRoll = UIAlertAction(title: "Select from Camera Roll", style: .default) { (action) in
            let imagePickerController = UIImagePickerController()
            /* Only allow photos to be picked, not taken. This sets the image picker controller's source (where it can get pictures) */
            imagePickerController.sourceType = .photoLibrary
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraRoll)
        
        let newPhoto = UIAlertAction(title: "Take new Photo", style: .default) { (action) in
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                let picker = UIImagePickerController()
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                self.present(picker, animated: true, completion: nil)
            } else {
                let alertVC = UIAlertController(
                    title: "No Camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                self.present(alertVC,
                             animated: true,
                             completion: nil)
            }
        }
        // - Attribution: http://stackoverflow.com/questions/25759885/uiactionsheet-from-popover-with-ios8-gm
        // compatible with iPad
        alertController.addAction(newPhoto)
        alertController.popoverPresentationController?.sourceView = self.view
        //alertController.popoverPresentationController?.sourceRect = self.view.bounds
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
        
        // MARK: - UIImagePickerControllerDelegate Methods
        
        // - Attribution: http://stackoverflow.com/questions/39009889/xcode-8-creating-an-image-format-with-an-unknown-type-is-an-error
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage!
            self.image = image!
            petImageView.image = self.image
            //self.tableView.reloadData()
            dismiss(animated: true, completion: nil)
            
        }

    }
    
    

