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
    var itemStoreGreaterThan50: [Item] {
        var items = [Item]()
        for item: Item in itemStore.allItems where item.valueInDollars > 50 {
            items.append(item)
        }
        return items
    }
    
    var itemStoreLessThan50: [Item] {
        var items = [Item]()
        for item: Item in itemStore.allItems where item.valueInDollars <= 50 {
            items.append(item)
        }
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    // MARK: UITableViewDataSource methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemStoreGreaterThan50.count
        }
        else {
            return itemStoreLessThan50.count
        }
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ">50"
        }
        else {
            return "<=50"
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        var item: Item
        
        if indexPath.section == 0 {
            item = itemStoreGreaterThan50[indexPath.row]
        }
        else {
            item = itemStoreLessThan50[indexPath.row]
        }
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
}