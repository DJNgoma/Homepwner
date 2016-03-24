//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by Daliso Ngoma on 24/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController {
    
    
    @IBOutlet var changedDate: UIDatePicker!
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        changedDate.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = changedDate.date
    }
}