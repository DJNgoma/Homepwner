//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Daliso Ngoma on 21/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "ocean"))
        tableView.backgroundView?.contentMode = .ScaleAspectFill
        tableView.separatorStyle = .None
        
    }
    
    // MARK: UITableViewDataSource methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if !(itemStore.allItems.count == indexPath.row) {
            return 60
        } else {
            return tableView.rowHeight
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        if !(itemStore.allItems.count == indexPath.row) {
            let item = itemStore.allItems[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            cell.textLabel?.font = cell.textLabel?.font.fontWithSize(20)
            cell.detailTextLabel?.font = cell.detailTextLabel?.font.fontWithSize(20)
        } else {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        }
        
        cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        
        return cell
    }
    
}