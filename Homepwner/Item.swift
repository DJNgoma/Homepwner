//
//  Item.swift
//  Homepwner
//
//  Created by Daliso Ngoma on 21/03/2016.
//  Copyright © 2016 Daliso Ngoma. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    
    init(name: String, serialNumber: String?, valueInDollars: Int, dateCreated: NSDate) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = dateCreated ?? NSDate()
        
        super.init()
    }
    
    convenience init(random: Bool = false)  {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue, dateCreated: NSDate())
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0, dateCreated: NSDate())
        }
    }
}