//
//  AddListTableViewController.swift
//  AMT
//
//  Created by Jesus Arechiga on 5/4/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit
import CoreData

class AddListTableViewController: UITableViewController {
    
    @IBOutlet weak var listNameTextField:UITextField!
    @IBOutlet weak var purpleButton:UIButton!
    @IBOutlet weak var blueButton:UIButton!
    @IBOutlet weak var greenButton:UIButton!
    @IBOutlet weak var redButton:UIButton!
    @IBOutlet weak var orangeButton:UIButton!
    @IBOutlet weak var yellowButton:UIButton!
    
    var isColor = ""
    
    var list:List!

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

    func navigationController(navigationController: UINavigationController!,
        willShowViewController viewController: UIViewController!, animated: Bool)
    {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }

    @IBAction func save() {
            
            // Form validation
            var errorField = ""
            
            if listNameTextField.text == "" {
                errorField = "name"
            }
            if isColor == "" {
            errorField = "color"
            }
        
            if errorField != "" {
                    
                    let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the list " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
                    let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(doneAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    return
            }
            
            // If all fields are correctly filled in, extract the field value
            println("Name: " + listNameTextField.text)
            
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                AppDelegate).managedObjectContext {
                list = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext:managedObjectContext) as! List
                list.listName = listNameTextField.text
                list.isColor = isColor
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
                }
            }
         
            
            // Execute the unwind segue and go back to the home screen
            performSegueWithIdentifier("unwindToListScreen", sender: self)
    }
    
    
    @IBAction func updateIsColor(sender: AnyObject)
    {
        // Yes button clicked
        let buttonClicked = sender as! UIButton
        if buttonClicked == purpleButton
        {
            isColor = "list_purple.png"
        purpleButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
        blueButton.backgroundColor = UIColor.grayColor()
        greenButton.backgroundColor = UIColor.grayColor()
        redButton.backgroundColor = UIColor.grayColor()
        orangeButton.backgroundColor = UIColor.grayColor()
        yellowButton.backgroundColor = UIColor.grayColor()
        }
        else if buttonClicked == blueButton
        {
            isColor = "list_blue.png"
            blueButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
            purpleButton.backgroundColor = UIColor.grayColor()
            greenButton.backgroundColor = UIColor.grayColor()
            redButton.backgroundColor = UIColor.grayColor()
            orangeButton.backgroundColor = UIColor.grayColor()
            yellowButton.backgroundColor = UIColor.grayColor()
        }
        else if buttonClicked == greenButton
        {
            isColor = "list_green.png"
            greenButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0,alpha:1.0)
            blueButton.backgroundColor = UIColor.grayColor()
            purpleButton.backgroundColor = UIColor.grayColor()
            redButton.backgroundColor = UIColor.grayColor()
            orangeButton.backgroundColor = UIColor.grayColor()
            yellowButton.backgroundColor = UIColor.grayColor()
        }
        else if buttonClicked == redButton
        {
            isColor = "list_red.png"
            redButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
            blueButton.backgroundColor = UIColor.grayColor()
            greenButton.backgroundColor = UIColor.grayColor()
            purpleButton.backgroundColor = UIColor.grayColor()
            orangeButton.backgroundColor = UIColor.grayColor()
            yellowButton.backgroundColor = UIColor.grayColor()
        }
        else if buttonClicked == orangeButton
        {
            isColor = "list_orange.png"
            orangeButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
            blueButton.backgroundColor = UIColor.grayColor()
            greenButton.backgroundColor = UIColor.grayColor()
            redButton.backgroundColor = UIColor.grayColor()
            purpleButton.backgroundColor = UIColor.grayColor()
            yellowButton.backgroundColor = UIColor.grayColor()
        }
        else if buttonClicked == yellowButton
        {
            isColor = "list_yellow.png"
            yellowButton.backgroundColor = UIColor(red:140.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha:1.0)
            blueButton.backgroundColor = UIColor.grayColor()
            greenButton.backgroundColor = UIColor.grayColor()
            redButton.backgroundColor = UIColor.grayColor()
            orangeButton.backgroundColor = UIColor.grayColor()
            purpleButton.backgroundColor = UIColor.grayColor()
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
