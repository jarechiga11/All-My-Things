//
//  AddItemTableViewController.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/29/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit
import CoreData

class AddItemTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var dateTextField:UITextField!
    @IBOutlet weak var priceTextField:UITextField!
    @IBOutlet weak var descriptionTextField:UITextField!
    @IBOutlet weak var listTextField:UITextField!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!
    
    var isBorrowed = true
    
    var item:Item!

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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
                imagePicker.delegate = self
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo
                info: [NSObject : AnyObject])
    {
                    imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
                    imageView.contentMode = UIViewContentMode.ScaleAspectFill
                    imageView.clipsToBounds = true
                    dismissViewControllerAnimated(true, completion: nil)
    }
    
    func navigationController(navigationController: UINavigationController,
            willShowViewController viewController: UIViewController, animated: Bool) {
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    
    @IBAction func save() {
        
        // Form validation
        var errorField = ""
        
        if nameTextField.text == "" {
            errorField = "name"
        } else if dateTextField.text == "" {
            errorField = "date of purchase"
        } else if priceTextField.text == "" {
            errorField = "price"
        }else if descriptionTextField.text == "" {
            errorField = "description"
        }else if listTextField.text == "" {
            errorField = "list"
        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the item " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        // If all fields are correctly filled in, extract the field value
        println("Name: " + nameTextField.text)
        println("Date of Purchase: " + dateTextField.text)
        println("Price: " + priceTextField.text)
        println("Description: " + descriptionTextField.text)
        println("List: " + listTextField.text)
        println("Have you been here: " + (isBorrowed ? "yes" : "no"))
        
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: managedObjectContext) as! Item
            item.name = nameTextField.text
            item.dateOfPurchase = dateTextField.text
            item.price = priceTextField.text
            item.descriptionItem = descriptionTextField.text
            item.list = listTextField.text
            item.picture = UIImagePNGRepresentation(imageView.image)
            item.isBorrowed = isBorrowed
            var e: NSError?
            if managedObjectContext.save(&e) != true {
            println("insert error: \(e!.localizedDescription)")
            return
            }
        }
        
        
        
        // Execute the unwind segue and go back to the home screen
        performSegueWithIdentifier("unwindToItemScreen", sender: self)
    }
    
    @IBAction func updateIsBorrowed(sender: AnyObject) {
            // Yes button clicked
            let buttonClicked = sender as! UIButton
            if buttonClicked == yesButton {
                isBorrowed = true
                yesButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
                noButton.backgroundColor = UIColor.grayColor()
            } else if buttonClicked == noButton {
                isBorrowed = false
                yesButton.backgroundColor = UIColor.grayColor()
                noButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
            }
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
