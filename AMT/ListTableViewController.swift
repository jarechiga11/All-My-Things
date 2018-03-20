//
//  ListTableViewController.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/16/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    
    var lists:[List] =
    [
        //List(listName: "Default", isColor: "list_gray.png"),
        //List(listName: "Private", isColor: "list_lock.png"),
        //List(listName: "Borrowed", isColor: "list_gray.png"),
        //List(listName: "Trash", isColor: "list_trash.png")
    ]
    
    var fetchResultController:NSFetchedResultsController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
        target: nil, action: nil)
        
        var fetchRequest = NSFetchRequest(entityName: "List")
        let sortDescriptor = NSSortDescriptor(key: "listName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext
        {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            lists = fetchResultController.fetchedObjects as! [List]
            if result != true
            {
                println(e?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return self.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        // Configure the cell...
        let list = lists[indexPath.row]
        cell.nameLabel.text = list.listName
        cell.thumbnailImageView.image = UIImage(named: list.isColor)
        // Circular Image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:
            UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source
          self.lists.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
        println("Total item: \(self.lists.count)")
        for name in lists
        {
            println(name)
        }

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath:
        NSIndexPath) -> [AnyObject]
    {
            var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:
        {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                {
                    let listToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as!            List
                    managedObjectContext.deleteObject(listToDelete)
                    var e: NSError?
                    if managedObjectContext.save(&e) != true
                    {
                        println("delete error: \(e!.localizedDescription)")
                    }
                }
        })
            return [deleteAction]
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
            // Return the number of sections.
            return 1
    }
    
    
    @IBAction func unwindToListScreen(segue:UIStoryboardSegue) {
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!,atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!)
    {
            switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
            }
            lists = controller.fetchedObjects as! [List]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0
    }
    */
    
    
    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0
    }
    */
    
    
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
