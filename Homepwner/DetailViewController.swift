//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Daliso Ngoma on 23/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true) // Don't have to worry which UITextField needs their firstResponder resigned.
    }
    
    func crossHair() -> UIView {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let previewHeight = screenWidth + (screenWidth/3)
        let screenHeight = UIScreen.mainScreen().bounds.size.width
        let totalBlack = screenHeight - previewHeight
        let heightOfBlackTopAndBottom = totalBlack / 2
        
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath()
        
        let bounds = imagePicker.view.bounds
        
        path.moveToPoint(CGPointMake(bounds.width/2, -(heightOfBlackTopAndBottom/2)))
        path.addLineToPoint(CGPointMake(bounds.width/2, bounds.height + (heightOfBlackTopAndBottom*2)))
        path.closePath()
        
        path.moveToPoint(CGPointMake(0, bounds.height/2))
        path.addLineToPoint(CGPointMake(bounds.height, bounds.height/2))
        path.closePath()
        
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.yellowColor().CGColor
        shapeLayer.lineWidth = 1.0
        
        let crossHairView = UIView()
        crossHairView.layer.addSublayer(shapeLayer)
        return crossHairView
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        imagePicker.allowsEditing = true
        
        // If the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
            
            imagePicker.cameraOverlayView = crossHair()
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clearPicture(sender: UIBarButtonItem) {
        
        imageStore.deleteImageForKey(item.itemKey)
        
        // Remove image on the screen in the image view
        imageView.image = nil
        
    }
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserverForName("_UIImagePickerControllerUserDidCaptureItem", object:nil, queue:nil, usingBlock: { note in
            self.imagePicker.cameraOverlayView = nil;
        })
        NSNotificationCenter.defaultCenter().addObserverForName("_UIImagePickerControllerUserDidRejectItem", object:nil, queue:nil, usingBlock: { note in
            self.imagePicker.cameraOverlayView = self.crossHair();
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.imageForKey(key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "_UIImagePickerControllerUserDidCaptureItem", object: nil)
    }
    
    // MARK: UITextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismissViewControllerAnimated(true, completion: nil)
    }
}