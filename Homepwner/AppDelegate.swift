//
//  AppDelegate.swift
//  Homepwner
//
//  Created by Daliso Ngoma on 21/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let itemStore = ItemStore()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Create an ImageStore
        let imageStore = ImageStore()
        
        // Access the ItemsViewController and set its item store
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! ItemsViewController
        itemsController.itemStore = itemStore
        itemsController.imageStore = imageStore
        
        return true
    }


    func applicationDidEnterBackground(application: UIApplication) {
        
        let success = itemStore.saveChanges()
        if (success) {
            print("Saved all of the Items")
        }
        else {
            print("Could not save any of the Items")
        }
    }


}

