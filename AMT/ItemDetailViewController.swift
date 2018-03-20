//
//  ItemDetailViewController.swift
//  AMT
//
//  Created by Jesus Arechiga on 4/23/15.
//  Copyright (c) 2015 RAD. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var itemImageView:UIImageView!
    var item:Item!
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            as! ItemDetailTableViewCell
        // Configure the cell...
        switch indexPath.row
        {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = item.name
        case 1:
            cell.fieldLabel.text = "Date Of Purchase"
            cell.valueLabel.text = item.dateOfPurchase
        case 2:
            cell.fieldLabel.text = "Price"
            cell.valueLabel.text = item.price
        case 3:
            cell.fieldLabel.text = "Description"
            cell.valueLabel.text = item.descriptionItem
        case 4:
            cell.fieldLabel.text = "List"
            cell.valueLabel.text = item.list
        case 5:
            cell.fieldLabel.text = "Loaned Out?"
            cell.valueLabel.text = (item.isBorrowed.boolValue) ? "Yes" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.itemImageView.image = UIImage(data: item.picture)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        title = self.item.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
