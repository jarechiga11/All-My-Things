//
//  ItemViewControllerTableViewController.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/16/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var items:[Item] = []
    var fetchResultController:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            items = fetchResultController.fetchedObjects as! [Item]
            if result != true {
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
        return self.items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell
    {
            let itemCellIdentifier = "ItemCell"
            let itemCell = tableView.dequeueReusableCellWithIdentifier(itemCellIdentifier, forIndexPath: indexPath) as! CustomItemViewCell
            // Configure the cell...
            let item = items[indexPath.row]
            itemCell.itemNameLabel.text = item.name
            itemCell.itemThumbnailImageView.image = UIImage(data: item.picture)
            // Circular Image
            //itemCell.itemThumbnailImageView.layer.cornerRadius = itemCell.itemThumbnailImageView.frame.size.width/2
            //itemCell.itemThumbnailImageView.layer.cornerRadius = 10.0
            itemCell.itemThumbnailImageView.clipsToBounds = true
            return itemCell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:
            UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source
            self.items.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
        println("Total item: \(self.items.count)")
        for name in items
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
                    let itemToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as!            Item
                    managedObjectContext.deleteObject(itemToDelete)
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "showItemDetails"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow()
            {
                let destinationController = segue.destinationViewController as! ItemDetailViewController
                destinationController.item = self.items[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToItemScreen(segue:UIStoryboardSegue) {
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        tableView.beginUpdates()
    }
    
    func controller(controller:NSFetchedResultsController!, didChangeObject anObject: AnyObject!,
        atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath!) {
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
        items = controller.fetchedObjects as! [Item]
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
    
    
    
    
    /*
    if editingStyle == .Delete
    {
    // Delete the row from the data source
    self.items.removeAtIndex(indexPath.row)
    self.tableView.reloadData()
    }
    println("Total item: \(self.items.count)")
    for name in items
    {
    println(name)
    }
    */
    
}
